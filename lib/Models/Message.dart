import 'package:json_annotation/json_annotation.dart';

part 'Message.g.dart';

@JsonSerializable()
class Message{
  int id;
  String message;
  bool mine;
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  Message({this.id, this.message, this.mine, this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);


}