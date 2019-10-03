import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:html' as html;

class WebImagePicker {

  static Future<Image> pickImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input..accept = 'image/*';
    input.click();
    await input.onChange.first;
    if (input.files.isEmpty) return null;
    final reader = html.FileReader();
    reader.readAsDataUrl(input.files[0]);
    await reader.onLoad.first;
    final encoded = reader.result as String;
    // remove data:image/*;base64 preambule
    final stripped =
        encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

    final name = input.files?.first?.name;
    final data = base64.decode(stripped);
    return Image.memory(data, semanticLabel: name);
  }
}
