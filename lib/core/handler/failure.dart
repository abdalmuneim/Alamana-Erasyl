abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({String message = ''}) : super(message);
}
