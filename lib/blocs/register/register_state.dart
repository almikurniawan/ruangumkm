abstract class RegisterState{}

class RegisterInitial extends RegisterState{}

class RegisterFinished extends RegisterState{
  final int errorCode;
  final String errorMessage;
  
  RegisterFinished({
    required this.errorCode,
    required this.errorMessage,
  });
}