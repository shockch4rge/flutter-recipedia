import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/utils/document_serializer.dart';
import 'package:flutter_recipedia/utils/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class User {
  final DocumentReference id;
  final String username;
  final String name;
  final String avatarUrl;
  final String bio;
  final List<DocumentReference> followers;
  final List<DocumentReference> following;

  static const collectionName = "users";
  static final idField = FieldPath.documentId;
  static const usernameField = "username";
  static const nameField = "name";
  static const avatarUrlField = "avatarUrl";
  static const bioField = "bio";
  static const followersField = "followers";
  static const followingField = "following";

  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });

  factory User.fromFirestore(DocumentSnapshot snap, dynamic _) {
    final json = snap.data()! as JsonResponse;
    json["id"] = snap.reference;

    return User.fromJson(json);
  }

  static JsonResponse toFirestore(User user, dynamic _) => user.toJson();

  factory User.fromJson(JsonResponse json) => _$UserFromJson(json);

  JsonResponse toJson() => _$UserToJson(this);
}
