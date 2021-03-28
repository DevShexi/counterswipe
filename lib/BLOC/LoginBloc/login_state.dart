part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool valid;
  final email;
  final password;
  final emailError;
  final passwordError;
  LoginState(
      {this.email,
      this.password,
      this.emailError,
      this.passwordError,
      this.valid});

  LoginState copyWith({email, password, emailError, passwordError, valid}) {
    return LoginState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      valid: valid ?? this.valid,
    );
  }

  @override
  List<Object> get props => [email, password, emailError, passwordError, valid];
}

class LoginSuccess extends LoginState {
  LoginSuccess();
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  LoginFailed();
  @override
  List<Object> get props => [];
}

class ValidateUserLogin extends LoginState {
  final email;
  final password;
  ValidateUserLogin({@required this.email, @required this.password});
  List<Object> get props => [email, password];
}

class NoUserExists extends LoginState {
  final emailError;
  NoUserExists({this.emailError});
  List<Object> get props => [emailError];
}

class InvalidPassword extends LoginState {
  final passwordError;
  InvalidPassword({this.passwordError});
  List<Object> get props => [passwordError];
}
