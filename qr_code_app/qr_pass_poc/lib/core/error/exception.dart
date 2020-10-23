abstract class CoWException implements Exception {
  String message;
}

class ServerException implements CoWException {
  int code;

  @override
  String message;

  ServerException(this.code, [this.message]);
}

class CacheException implements CoWException {
  @override
  String message;

  CacheException(this.message);
}