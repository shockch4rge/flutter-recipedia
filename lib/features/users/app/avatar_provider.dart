import 'dart:io';

import 'package:flutter/material.dart';

// this provider is used to avoid the need to pass the user's avatar up the widget tree
class AvatarProvider with ChangeNotifier {
  // save the avatar image file here
  File? uploadedAvatar;

  void setUploadedAvatar(File? file) {
    uploadedAvatar = file;
    notifyListeners();
  }

  void reset() {
    // delete the image as we don't want to keep it in the device's memory
    uploadedAvatar?.deleteSync();
    // set the current image to null
    setUploadedAvatar(null);
  }
}
