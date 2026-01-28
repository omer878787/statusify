import '../entities/caption.dart';
import '../entities/caption_filters.dart';

abstract class CaptionsRepository {
  Future<List<Caption>> getCaptions(CaptionFilters filters);
  // later:
  // Future<List<Caption>> generateAiCaptions(CaptionFilters filters);
}
