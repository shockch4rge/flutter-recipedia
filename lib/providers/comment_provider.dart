import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class CommentProvider with ChangeNotifier {
  User? replyTarget;

  void setReplyTarget(User? user) {
    replyTarget = user;
    notifyListeners();
  }
}
