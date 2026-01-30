import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:statusify/core/network/network_helper.dart';
import 'package:statusify/features/captions/data/datasources/captions_local_ds.dart';
import 'package:statusify/features/captions/data/datasources/openai_api.dart';
import 'package:statusify/features/captions/data/repositories/captions_repository_impl.dart';
import 'package:statusify/features/captions/domain/repositories/captions_repository.dart';
import 'package:statusify/features/captions/domain/usecases/get_captions.dart';
import 'package:statusify/features/captions/domain/usecases/get_captions_open_ai.dart';
import 'package:statusify/features/captions/presentation/bloc/captions_bloc.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Data sources
  sl.registerLazySingleton(() => CaptionsLocalDataSource());
  sl.registerLazySingleton<Dio>(() {
    return NetworkHelper.createDio(
      baseUrl: 'https://api.openai.com/v1',
      openAiKey:
          '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',
    );
  });
  sl.registerLazySingleton(() => OpenAiApi(sl()));
  // Repository
  sl.registerLazySingleton<CaptionsRepository>(
    () => CaptionsRepositoryImpl(local: sl(), openAiApi: sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => GetCaptions(sl()));
  sl.registerLazySingleton(() => GetCaptionsOpenAi(sl()));
  // BLoC (factory so new instance when needed)
  sl.registerFactory(() => CaptionsBloc(getCaptions: sl()));
}
