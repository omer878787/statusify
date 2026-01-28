// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caption_filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptionFilters _$CaptionFiltersFromJson(Map<String, dynamic> json) =>
    CaptionFilters(
      category: json['category'] as String,
      language: json['language'] as String,
      platform: json['platform'] as String,
      emojiStyle: json['emojiStyle'] as String,
      count: (json['count'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$CaptionFiltersToJson(CaptionFilters instance) =>
    <String, dynamic>{
      'category': instance.category,
      'language': instance.language,
      'platform': instance.platform,
      'emojiStyle': instance.emojiStyle,
      'count': instance.count,
    };
