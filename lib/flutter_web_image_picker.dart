library flutter_web_image_picker;

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/web_image_picker.dart';
import 'src/bean/web_image_info.dart';

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
  static Future<WebImageInfo> get getImageInfo async {
    final data =
    await _methodChannel.invokeMapMethod<String, dynamic>('pickImage');
    WebImageInfo _webImageInfo = WebImageInfo();
    _webImageInfo.fileName = data['name'];
    _webImageInfo.filePath = data['path'];
    _webImageInfo.base64 = data['data'];
    _webImageInfo.base64WithScheme = data['data_scheme'];
    _webImageInfo.data = base64.decode(data['data']);
    return _webImageInfo;
  }
}
