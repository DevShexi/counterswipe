import 'package:counterswipe/BLOC/LoginBloc/login_bloc.dart';
import 'package:counterswipe/Presentation/widgets/inputfield.dart';
import 'package:counterswipe/Presentation/widgets/submitButton.dart';
import 'package:counterswipe/Services/FirebaseAuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text('Login was Successful'),
              ));
              Future.delayed(
                Duration(seconds: 2),
              );
              Navigator.pushNamed(context, '/counter');
            }
            if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text('Login Failed. Please try again'),
              ));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/01.png"), fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: MediaQuery.of(context).size.width - 20,
                          // height: MediaQuery.of(context).size.height * 2 / 3,
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: 25),
                                  InputField(
                                    label: "Email",
                                    hint: "Email",
                                    errorText: state.emailError,
                                    onChange: (email) {
                                      context.read<LoginBloc>().add(
                                            EmailChanged(email: email),
                                          );
                                    },
                                    controller: emailController,
                                  ),
                                  InputField(
                                    label: "Password",
                                    hint: "Password",
                                    isObscure: true,
                                    errorText: state.passwordError,
                                    onChange: (password) {
                                      context.read<LoginBloc>().add(
                                            PasswordChanged(password: password),
                                          );
                                    },
                                    controller: passwordController,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SubmitButton(
                                          label: "Sign In",
                                          submitAction: () async {
                                            final authResponse =
                                                await UserAuthentication.login(
                                                    state.email,
                                                    state.password);
                                            emailController.clear();
                                            passwordController.clear();
                                            switch (authResponse) {
                                              case "user found":
                                                {
                                                  context.read<LoginBloc>().add(
                                                        AttemptLogin(
                                                          email: state.email,
                                                          password: state,
                                                        ),
                                                      );
                                                }
                                                break;
                                              case "no record found":
                                                {
                                                  context.read<LoginBloc>().add(
                                                        FireUserNotFound(),
                                                      );
                                                }
                                                break;
                                              case "incorrect password":
                                                {
                                                  context.read<LoginBloc>().add(
                                                        FireWrongPassword(),
                                                      );
                                                }
                                                break;
                                              default:
                                                {
                                                  context.read<LoginBloc>().add(
                                                        FireLoginFailed(),
                                                      );
                                                }
                                            }
                                            if (authResponse == "user found") {
                                              context.read<LoginBloc>().add(
                                                    AttemptLogin(
                                                      email: state.email,
                                                      password: state,
                                                    ),
                                                  );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: -12,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
