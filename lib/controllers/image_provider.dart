


import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageUpoader extends ChangeNotifier {
 var uuid = Uuid();
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = await cropImage(_imageFile!);
    if (_imageFile != null) {
      imageFil.add(_imageFile.path);
      imageUpload(_imageFile);
      imagePath = _imageFile.path;
    } else {
      return;
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    final croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      maxHeight: 800,
      maxWidth: 600,
      compressQuality: 70,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio5x4,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper', //change it later
          toolbarColor: Color(kLightBlue.value),
          toolbarWidgetColor: Color(kLight.value),
          initAspectRatio: CropAspectRatioPreset.ratio5x4,
          lockAspectRatio: true,
        ),
      ],
    );

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<String?> imageUpload(XFile upload) async {
    File image = File(upload.path);

    final ref = FirebaseStorage.instance
        .ref()
        .child("jobhub")
        .child("${uuid.v1()}.jpg");
    await ref.putFile(image);

    imageUrl = await ref.getDownloadURL();
    print(imageUrl);
    return imageUrl;
  }
}

/*
import 'dart:typed_data';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:uuid/uuid.dart';

class ImageUploader extends ChangeNotifier {
  var uuid = Uuid();
  final ImagePicker _picker = ImagePicker();
  final Db _db = Db('mongodb://localhost:27017/my_database'); // تحديد عنوان قاعدة البيانات

  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  Future<void> pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = await cropImage(_imageFile!);
    if (_imageFile != null) {
      imageFil.add(_imageFile.path);
      await imageUpload(File(_imageFile.path));
      imagePath = _imageFile.path;
    } else {
      return;
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    final croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      maxHeight: 800,
      maxWidth: 600,
      compressQuality: 70,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio5x4,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'JobHub Cropper', //change it later
        toolbarColor: Color(kLightBlue.value),
        toolbarWidgetColor: Color(kLight.value),
        initAspectRatio: CropAspectRatioPreset.ratio5x4,
        lockAspectRatio: true,
      ),
    );

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<void> imageUpload(File imageFile) async {
    try {
      await _db.open();
      final GridFS fs = GridFS(_db);
      
      // تحميل الصورة إلى قاعدة البيانات
      final id = await fs.putFromStream(imageFile.path, imageFile.openRead());
      
      // احصل على عنوان URL للصورة
      final url = 'http://localhost:27017/my_database/fs/$id';

      imageUrl = url;
      print(imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      await _db.close();
    }
  }
}
*/