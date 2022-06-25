import 'dart:io';

import 'package:flutter/material.dart';

class AvatarProvider with ChangeNotifier {
  File? uploadedAvatar;

  void setUploadedAvatar(File? file) {
    uploadedAvatar = file;
    notifyListeners();
  }

  void reset() {
    uploadedAvatar?.deleteSync();
    setUploadedAvatar(null);
  }
}
