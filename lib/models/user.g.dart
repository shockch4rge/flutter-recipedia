// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: const DocumentSerializer()
          .fromJson(json['id'] as DocumentReference<Object?>),
      username: json['username'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      bio: json['bio'] as String,
      followers: (json['followers'] as List<dynamic>)
          .map((e) => const DocumentSerializer()
              .fromJson(e as DocumentReference<Object?>))
          .toList(),
      following: (json['following'] as List<dynamic>)
          .map((e) => const DocumentSerializer()
              .fromJson(e as DocumentReference<Object?>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': const DocumentSerializer().toJson(instance.id),
      'username': instance.username,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'followers':
          instance.followers.map(const DocumentSerializer().toJson).toList(),
      'following':
          instance.following.map(const DocumentSerializer().toJson).toList(),
    };
