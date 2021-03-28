part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final email;
  const EmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final password;
  const PasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class FireUserNotFound extends LoginEvent {
  const FireUserNotFound();
}

class FireWrongPassword extends LoginEvent {
  const FireWrongPassword();
}

class FireLoginFailed extends LoginEvent {
  const FireLoginFailed();
}

class AttemptLogin extends LoginEvent {
  final email;
  final password;
  const AttemptLogin({@required this.email, @required this.password});
  List<Object> get props => [email, password];
}
