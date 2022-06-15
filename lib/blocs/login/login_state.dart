abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginFinished extends LoginState {
  final int errorCode; // 0 = success, 1 = username not found, 2 = password wrong
  final String errorMessage;

  LoginFinished({
    required this.errorCode,
    required this.errorMessage,
  });
}

class LogoutFinished extends LoginState {
  final int errorCode; // 0 = success
  final String errorMessage;

  LogoutFinished({
    required this.errorCode,
    required this.errorMessage,
  });
}