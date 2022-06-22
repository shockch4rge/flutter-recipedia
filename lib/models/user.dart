import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_recipedia/utils/document_serializer.dart';
import 'package:flutter_recipedia/utils/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class User {
  @JsonKey(required: true)
  final DocumentReference id;
  final String username;
  final String name;
  final String avatarUrl;
  final String bio;
  final List<DocumentReference> followers;
  final List<DocumentReference> following;

  static final idField = FieldPath(const ["id"]);

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
    // return User(
    //   id: snap.reference,
    //   name: snap.get("name"),
    //   username: snap.get("username"),
    //   bio: snap.get("bio"),
    //   avatarUrl: snap.get("avatarUrl"),
    //   followers: snap.get("followers"),
    //   following: snap.get("following"),
    // );
    final json = snap.data()! as JsonResponse;
    json["id"] = snap.reference;

    return User.fromJson(json);
  }

  static Map<String, dynamic> toFirestore(User user, dynamic _) =>
      user.toJson();

  factory User.fromJson(JsonResponse json) => _$UserFromJson(json);

  JsonResponse toJson() => _$UserToJson(this);
}
