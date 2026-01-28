import '../../domain/entities/caption_filters.dart';

sealed class CaptionsEvent {}

class CaptionsRequested extends CaptionsEvent {
  final CaptionFilters filters;
  CaptionsRequested(this.filters);
}
