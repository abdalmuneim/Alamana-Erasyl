class ServerService<T> {
  //timeout duration
  Future<T> timeOutMethod(Future<T> Function() function) async {
    return await Future.delayed(const Duration(seconds: 10), () async {
      return await function();
    });
  }
}
// TODO: #13 package_info_plus_windows-2.1.0 Error: Field 'wCodePage' cannot be nullable or have type 'Null' @abdalmuneim