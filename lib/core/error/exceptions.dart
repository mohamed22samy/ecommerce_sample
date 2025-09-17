abstract class AppApiException implements Exception {
}


class ServerException<T> implements AppApiException {
  final T message;

  ServerException(this.message);
}

class UnAuthenticatedException<T> implements AppApiException {
  final T message;

  UnAuthenticatedException(this. message);
}

class CacheException implements AppApiException {


}