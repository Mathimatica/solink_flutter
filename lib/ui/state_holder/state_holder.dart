import 'package:flutter/material.dart';
import 'package:solink_flutter/network/data/photo_response.dart';

sealed class StateHolder<T> {
  const StateHolder();
}

class Loading extends StateHolder<Never> {
  const Loading();
}

class Success<T> extends StateHolder<T> {
  final T data;
  const Success(this.data);
}

class Error extends StateHolder<Never> {
  final String? message;
  const Error(this.message);
}

typedef UserStateHolder = ({String name, String imageUrl});

typedef UserListItemStateHolder = ({
  String name,
  String imageUrl,
  void Function(void Function(Photo) onClick) processOnClick,
});

typedef UserListStateHolder = ({
  List<UserListItemStateHolder> users,
});