import 'package:get_it/get_it.dart';
import 'package:solink_flutter/network/service/photo_service.dart';
import 'package:solink_flutter/network/service/user_service.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerLazySingleton(() => PhotoService());
  locator.registerLazySingleton(() => UserService());
}