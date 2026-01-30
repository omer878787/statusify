import 'package:statusify/core/usecase/usecase.dart';

import '../entities/caption.dart';
import '../entities/caption_filters.dart';
import '../repositories/captions_repository.dart';

class GetCaptionsOpenAi implements UseCase<List<Caption>, CaptionFilters> {
  final CaptionsRepository repo;
  const GetCaptionsOpenAi(this.repo);

  @override
  Future<List<Caption>> call(CaptionFilters params) {
    return repo.generateAiCaptions(params);
  }
}
