import 'package:clean_achitecture/features/sigin_signup/data/repository/login_repo_iml.dart';
import 'package:get_it/get_it.dart';

import 'features/sigin_signup/data/datasource/login_user.dart';
import 'features/sigin_signup/domain/repositories/login_repo.dart';
import 'features/sigin_signup/domain/usecases/login.dart';
import 'features/sigin_signup/presentation/bloc/login_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  initInjections(serviceLocator);
}

void initInjections(GetIt serviceLocator) {
  serviceLocator.registerFactory(
    () => LoginBloc(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => LoginUseCase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => LoginUser(),
  );
}
