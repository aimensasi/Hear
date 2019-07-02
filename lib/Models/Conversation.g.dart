// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
      id: json['id'] as int,
      name: json['name'] as String,
      displayName: json['display_name'] as String,
      language: json['language'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String));
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'display_name': instance.displayName,
      'language': instance.language,
      'created_at': instance.createdAt?.toIso8601String()
    };
