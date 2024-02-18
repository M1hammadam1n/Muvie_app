import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:move_app_1/domain/api_client/account_api_client.dart';
import 'package:move_app_1/domain/api_client/auth_api_client.dart';
import 'package:move_app_1/domain/data_providers/session_data_proviyder.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiClient _apiClient = AuthApiClient();
  final AccountApiClient _accountApiClient = AccountApiClient();
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  AuthBloc(AuthCheckStatusInProgressState authCheckStatusInProgressState) : super(AuthUnauthorizedState()) {
    on<AuthCheckStatusEvent>(_onAuthCheckStatusEvent, transformer: sequential());
    on<AuthLoginEvent>(_onAuthLoginEvent, transformer: sequential());
    on<AuthLogoutEvent>(_onAuthLogoutEvent, transformer: sequential());
  }

  Future<void> _onAuthCheckStatusEvent(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgressState());
    final sessionId = await _sessionDataProvider.getSessionId();
    final newState = sessionId != null ? AuthAuthorizedState() : AuthUnauthorizedState();
    emit(newState);
  }

  Future<void> _onAuthLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthInProgressState());
      final sessionId = await _apiClient.auth(
        username: event.login,
        password: event.password,
      );
      final accountId = await _accountApiClient.getAccountInfo(sessionId);
      await _sessionDataProvider.setSessionId(sessionId);
      await _sessionDataProvider.setAccountId(accountId);
      emit(AuthAuthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  Future<void> _onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _sessionDataProvider.deleteSessionId();
    await _sessionDataProvider.deleteAccountId();
    emit(AuthUnauthorizedState());
  }
}