import 'package:get_it/get_it.dart';
import 'package:solink_flutter/repository/photo_repository.dart';
import 'package:solink_flutter/repository/user_repository.dart';

final GetIt locator = GetIt.instance;

void setupRepositoryLocator() {
  locator.registerLazySingleton(() => PhotoRepository());
  locator.registerLazySingleton(() => UserRepository());
}