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