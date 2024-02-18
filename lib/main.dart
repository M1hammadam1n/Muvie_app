import 'package:flutter/material.dart';
import 'package:move_app_1/ui/widgets/app/my_app.dart';
import 'package:move_app_1/ui/widgets/network_controler/dependency_injection.dart';


Future<void> main() async {
  runApp(const MyApp());
  DependencyInjection.init();
}