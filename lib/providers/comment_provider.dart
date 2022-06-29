import 'package:flutter/cupertino.dart';

import '../models/recipe.dart';
import '../models/user.dart';

// this provider helps to gain focus on a user and their comment
// when 'reply' mode is activated in RecipeCommentsScreen.
class CommentProvider with ChangeNotifier {
  User? targetUser;
  RecipeComment? targetComment;

  bool get hasTarget => targetUser != null && targetComment != null;

  void setReplyTarget({User? user, RecipeComment? comment}) {
    targetUser = user;
    targetComment = comment;
    notifyListeners();
  }

  void reset() {
    targetUser = null;
    targetComment = null;
    notifyListeners();
  }
}
