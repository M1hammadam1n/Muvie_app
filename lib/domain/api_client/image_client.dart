import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:move_app_1/configuration/configuration.dart';

class ImageDownloader {
  static Widget cachedNetworkImage(String path, {int? width, int? height, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: Configuration.imageUrl + path,
      
    );
  }
}
