library flutter_web_image_picker;

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/web_image_picker.dart';

class FlutterWebImagePicker {
  static void registerWith(Registrar registrar) {
    final channel = MethodChannel('flutter_web_image_picker',
        const StandardMethodCodec(), registrar.messenger);
    final instance = WebImagePicker();
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'pickImage':
          return await instance.pickImage();
        default:
          throw MissingPluginException();
      }
    });
  }

  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_web_image_picker');

  static Future<Image> get getImage async {
    final data =
        await _methodChannel.invokeMapMethod<String, dynamic>('pickImage');
    final imageName = data['name'];
    final imageData = base64.decode(data['data']);
    return Image.memory(imageData, semanticLabel: imageName);
  }
}
