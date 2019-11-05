import 'dart:async';
import 'dart:html' as html;

class WebImagePicker {
  Future<Map<String, dynamic>> pickImage() async {
    print('pickImage');
    final Map<String, dynamic> data = {};
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
    //final imageBase64 = base64.decode(stripped);
    final imageName = input.files?.first?.name;
    final imagePath = input.files?.first?.relativePath;
    data.addAll({
      'name': imageName,
      'data': stripped,
      'data_scheme': encoded,
      'path': imagePath
    });
    return data;
  }
}
