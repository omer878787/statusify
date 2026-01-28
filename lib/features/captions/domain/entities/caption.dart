import 'package:json_annotation/json_annotation.dart';

part 'caption.g.dart';

@JsonSerializable()
class Caption {
  final String text;

  const Caption({required this.text});

  /// from json
  factory Caption.fromJson(Map<String, dynamic> json) =>
      _$CaptionFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$CaptionToJson(this);
}
