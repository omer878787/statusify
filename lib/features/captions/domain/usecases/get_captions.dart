import 'package:statusify/core/usecase/usecase.dart';

import '../entities/caption.dart';
import '../entities/caption_filters.dart';
import '../repositories/captions_repository.dart';

class GetCaptions implements UseCase<List<Caption>, CaptionFilters> {
  final CaptionsRepository repo;
  const GetCaptions(this.repo);

  @override
  Future<List<Caption>> call(CaptionFilters params) {
    return repo.getCaptions(params);
  }
}
