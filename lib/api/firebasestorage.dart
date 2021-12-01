import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class Firebase {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } catch (e) {
      return null;
    }
  }

  static Future<UploadTask?> uploadBytes(String destination, Uint8List data) {
    final ref = FirebaseStorage.instance.ref(destination);

    return Future.value(ref.putData(data));
  }
}
