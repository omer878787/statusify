import 'package:statusify/features/captions/domain/entities/caption.dart';

sealed class CaptionsState {}

class CaptionsInitial extends CaptionsState {}

class CaptionsLoading extends CaptionsState {}

class CaptionsLoaded extends CaptionsState {
  final List<Caption> items;
  CaptionsLoaded(this.items);
}

class CaptionsError extends CaptionsState {
  final String message;
  CaptionsError(this.message);
}
