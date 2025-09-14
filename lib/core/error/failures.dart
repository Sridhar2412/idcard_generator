sealed class Failure {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;
  const Failure(this.message, {this.cause, this.stackTrace});
}

class FileFailure extends Failure {
  const FileFailure(super.message, {super.cause, super.stackTrace});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.cause, super.stackTrace});
}
