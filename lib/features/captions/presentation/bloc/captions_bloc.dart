import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statusify/features/captions/domain/usecases/get_captions_open_ai.dart';
import 'captions_event.dart';
import 'captions_state.dart';

class CaptionsBloc extends Bloc<CaptionsEvent, CaptionsState> {
  final GetCaptionsOpenAi getCaptions;

  CaptionsBloc({required this.getCaptions}) : super(CaptionsInitial()) {
    on<CaptionsRequested>((event, emit) async {
      emit(CaptionsLoading());
      try {
        final items = await getCaptions(event.filters);
        emit(CaptionsLoaded(items));
      } on DioException catch (e) {
        final msg = _dioMessage(e);
        emit(CaptionsError(msg));
      } catch (e) {
        emit(CaptionsError(e.toString()));
      }
    });
  }

  String _dioMessage(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    if (status == 401) return 'Invalid API key (401).';
    if (status == 429) return 'Too many requests (429). Try again.';
    if (status != null) return 'Request failed ($status): $data';

    return e.message ?? 'Network error';
  }
}
