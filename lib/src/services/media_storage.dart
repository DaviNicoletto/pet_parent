import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();

Future<File?> selectPetImage() async {
  final _imagePicker = ImagePicker();
  final XFile? petImageFile =
      await _imagePicker.pickImage(source: ImageSource.gallery);

  if (petImageFile != null) {
    print(File(petImageFile.path));
    return File(petImageFile.path);
  } else {
    print('ta nulo');
    return null;
  }
}

Future<void> uploadPetImage(String petName, Function onImageUploaded) async {
  String fileName = "petsImages/${petName}.jpg";
  final petsImagesRef = storageRef.child(fileName);

  final imagePath = await selectPetImage();

  if (imagePath == null || !imagePath.existsSync()) {
    return;
  } else {
    try {
      UploadTask uploadTask = petsImagesRef.putFile(imagePath);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      print(taskSnapshot.ref.getDownloadURL());
      onImageUploaded();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}

Future<String> getPetsImages(String petName) async {
  final imgRef = storageRef.child('petsImages/${petName}.jpg');
  try {
    return imgRef.getDownloadURL();
  } on FirebaseException catch (e) {
    if (e.code == 'firebase_storage/object-not-found') {
      return "";
    } else {
      rethrow;
    }
  } catch (e) {
    print(e);
    return "ERRO: ${e}";
  }
}
