

class Failure implements Exception {
  final String message;
  final int? code;
  final Exception? exception;
  final StackTrace stackTrace;

  Failure({required this.message, this.code,this.exception, required this.stackTrace});

  @override
  String toString() {
    return 'Failure(message: $message, code: $code, exception: $exception)';
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Failure &&
      other.message == message &&
      other.code == code &&      
      other.exception == exception;
  }

  @override
  int get hashCode {
    return message.hashCode ^
      code.hashCode ^      
      exception.hashCode;
  }
}
