import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  // sl.registerLazySingleton<Dio>(() {
  //   return NetworkHelper.createDio(
  //     baseUrl: 'https://api.openai.com/v1',
  //     openAiKey: '',
  //   );
  // });
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
