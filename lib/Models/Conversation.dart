import 'package:hear/Models/Message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Conversation.g.dart';

@JsonSerializable()
class Conversation{
  int id;
  String name;
  @JsonKey(name: 'display_name')
  String displayName;
  String language;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  List<Message> messages;

  Conversation({this.id, this.name, this.displayName, this.language, this.createdAt});

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);

}