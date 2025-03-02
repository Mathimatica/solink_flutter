import 'package:get_it/get_it.dart';
import 'package:solink_flutter/view_model/user_list_view_model.dart';

final GetIt locator = GetIt.instance;

void setupViewModelLocator() {
  locator.registerFactoryParam<UserListViewModel, int, int>(
    (pageNum, pagePer) => UserListViewModel(pageNum: pageNum, pagePer: pagePer),
  );
}