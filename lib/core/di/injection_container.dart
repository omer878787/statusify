import 'package:get_it/get_it.dart';
import 'package:statusify/features/captions/data/datasources/captions_local_ds.dart';
import 'package:statusify/features/captions/data/repositories/captions_repository_impl.dart';
import 'package:statusify/features/captions/domain/repositories/captions_repository.dart';
import 'package:statusify/features/captions/domain/usecases/get_captions.dart';
import 'package:statusify/features/captions/presentation/bloc/captions_bloc.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Data sources
  sl.registerLazySingleton(() => CaptionsLocalDataSource());

  // Repository
  sl.registerLazySingleton<CaptionsRepository>(
    () => CaptionsRepositoryImpl(local: sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => GetCaptions(sl()));

  // BLoC (factory so new instance when needed)
  sl.registerFactory(() => CaptionsBloc(getCaptions: sl()));
}
