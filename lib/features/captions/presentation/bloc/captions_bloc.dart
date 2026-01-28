import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_captions.dart';
import 'captions_event.dart';
import 'captions_state.dart';

class CaptionsBloc extends Bloc<CaptionsEvent, CaptionsState> {
  final GetCaptions getCaptions;

  CaptionsBloc({required this.getCaptions}) : super(CaptionsInitial()) {
    on<CaptionsRequested>((event, emit) async {
      emit(CaptionsLoading());
      try {
        final items = await getCaptions(event.filters);
        emit(CaptionsLoaded(items));
      } catch (e) {
        emit(CaptionsError(e.toString()));
      }
    });
  }
}
