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

Future<String?> uploadPetImage() async {
  String fileName = "petsImages/${DateTime.now().microsecondsSinceEpoch}.jpg";
  final petsImagesRef = storageRef.child(fileName);

  final imagePath = await selectPetImage();

  if (imagePath == null || !imagePath.existsSync()) {
  } else {
    try {
      UploadTask uploadTask = petsImagesRef.putFile(imagePath);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      print(taskSnapshot.ref.getDownloadURL());
      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
  return null;
}
