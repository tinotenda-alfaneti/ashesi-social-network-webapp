import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload {
  XFile? _image;
  // method to upload an image
  Future<String?> uploadPic() async {
    final picker = ImagePicker();
    _image = await picker.pickImage(source: ImageSource.gallery);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("profile${DateTime.now().microsecondsSinceEpoch}");
    UploadTask uploadTask = ref.putFile(File(_image!.path));
    Completer<String?> completer = Completer<String?>();
    uploadTask.whenComplete(() async {
      String url = await ref.getDownloadURL();
      completer.complete(url);
    });
    return completer.future;
  }
}
