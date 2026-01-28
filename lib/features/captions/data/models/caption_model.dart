import '../../domain/entities/caption.dart';

class CaptionModel extends Caption {
  const CaptionModel({required super.text});

  factory CaptionModel.fromText(String text) => CaptionModel(text: text);
}
