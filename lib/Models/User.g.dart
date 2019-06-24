// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      email: json['email'] as String, language: json['language'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{'email': instance.email, 'language': instance.language};
