import 'package:statusify/core/utils/emoji_decorator.dart';

import '../../domain/entities/caption.dart';
import '../../domain/entities/caption_filters.dart';
import '../../domain/repositories/captions_repository.dart';
import '../datasources/captions_local_ds.dart';
import '../models/caption_model.dart';

class CaptionsRepositoryImpl implements CaptionsRepository {
  final CaptionsLocalDataSource local;

  CaptionsRepositoryImpl({required this.local});

  @override
  Future<List<Caption>> getCaptions(CaptionFilters filters) async {
    final raw = await local.getCaptions(
      category: filters.category,
      language: filters.language,
      platform: filters.platform,
    );

    final decorated = raw
        .take(filters.count)
        .map((t) => decorateWithEmojis(t, filters.emojiStyle))
        .map((t) => CaptionModel.fromText(t))
        .toList();

    return decorated;
  }
}
