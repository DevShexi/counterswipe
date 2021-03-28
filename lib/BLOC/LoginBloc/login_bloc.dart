import 'dart:async';

// import 'package:UFN/DATA/Repository/authRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:counterswipe/Services/FirebaseAuthService.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());
  // AuthenticationRepository authRepo = AuthenticationRepository();
  final auth = FirebaseAuth.instance;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      print('Email Changed Triggered from Bloc: ${event.email}');
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(event.email)) {
        yield state.copyWith(email: event.email, emailError: "");
      } else {
        yield state.copyWith(
            email: event.email,
            emailError: "Please Enter a valid email address");
      }
    } else if (event is PasswordChanged) {
      if (event.password.length < 6) {
        yield state.copyWith(
            password: event.password,
            passwordError: "Password must be atleast 6 characters long");
      } else {
        yield state.copyWith(
          password: event.password,
          passwordError: "",
        );
      }
    } else if (event is FireUserNotFound) {
      yield state.copyWith(
        emailError: "No record found for this email",
      );
    } else if (event is FireWrongPassword) {
      yield state.copyWith(
        passwordError: "Wrong Password",
      );
    } else if (event is AttemptLogin) {
      if (state.email != null &&
          state.password != null &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(state.email) &&
          state.password.length >= 6) {
        yield LoginSuccess();
      } else
        yield state.copyWith(
            email: null,
            emailError: "Please Ente a valid email address",
            password: null,
            passwordError: "Password must be atleast 6 characters long");
    } else if (event is FireLoginFailed) {
      yield LoginFailed();
    }
  }
}
