part of 'signup_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object> get props => [];
}

class UsernameChanged extends SignUpEvent {
  final username;
  const UsernameChanged({this.username});

  @override
  List<Object> get props => [username];
}

class EmailChanged extends SignUpEvent {
  final email;
  const EmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignUpEvent {
  final password;
  const PasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignUpEvent {
  final confirmPassword;
  const ConfirmPasswordChanged({this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword];
}

class FireUserExists extends SignUpEvent {
  const FireUserExists();

  @override
  List<Object> get props => [];
}

class AttemptSignUp extends SignUpEvent {
  final email;
  final password;
  final confirmPassword;
  const AttemptSignUp(
      {@required this.email,
      @required this.password,
      @required this.confirmPassword});
}
