class ServerService<T> {
  //timeout duration
  Future<T> timeOutMethod(Future<T> Function() function) async {
    return await Future.delayed(const Duration(seconds: 10), () async {
      return await function();
    });
  }
}
