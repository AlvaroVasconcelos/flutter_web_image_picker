# Flutter web image picker
[![pub package](https://img.shields.io/badge/Pub-v0.0.1-red)](https://pub.dev/packages/flutter_web_image_picker)

A package designed for input images on web flutter.

## Usage example

![](https://github.com/AlvaroVasconcelos/flutter_web_image_picker/raw/master/screenshots/01.gif)


``` dart 
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(image?.semanticLabel ?? ""),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_browser),
        onPressed: () async {
          final _image = await WebImagePicker.pickImage();
          setState(() {
            image = _image;
          });
        },
      ),
      body: Center(child: image != null ? image : Text('No data...')),
    );
}

```
##### Issues and feedback 
Please file issues to send feedback or report a bug. Thank you!

