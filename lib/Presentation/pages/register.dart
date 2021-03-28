import 'package:counterswipe/BLOC/SignupBloc/signup_bloc.dart';
import 'package:counterswipe/Presentation/widgets/inputfield.dart';
import 'package:counterswipe/Presentation/widgets/submitButton.dart';
import 'package:counterswipe/Services/FirebaseAuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SignUpFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text('SignUp Failed! Try a different Email'),
              ));
            }
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text('SignUp was Successful'),
              ));
              Future.delayed(
                Duration(seconds: 2),
              );
              Navigator.pushNamed(context, '/login');
            }
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/01.png"), fit: BoxFit.cover),
            ),
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
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 25),
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  overflow: Overflow.visible,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    Positioned(
                                        right: -24,
                                        child: RawMaterialButton(
                                          onPressed: () {},
                                          elevation: 2.0,
                                          fillColor: Colors.blue,
                                          child: Icon(
                                            Icons.add,
                                            size: 20.0,
                                            color: Colors.white,
                                          ),
                                          // padding: EdgeInsets.all(15.0),
                                          shape: CircleBorder(),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 25),
                                InputField(
                                  label: "User Name",
                                  hint: "User Name",
                                  onChange: (username) {
                                    print("Username: $username");
                                    context.read<SignUpBloc>().add(
                                          UsernameChanged(username: username),
                                        );
                                  },
                                  controller: usernameController,
                                ),
                                InputField(
                                  label: "Email",
                                  hint: "Email",
                                  errorText: state.emailError,
                                  onChange: (email) {
                                    context.read<SignUpBloc>().add(
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
                                    context.read<SignUpBloc>().add(
                                          PasswordChanged(password: password),
                                        );
                                  },
                                  controller: passwordController,
                                ),
                                InputField(
                                  label: "Confirm Password",
                                  hint: "Confirm Password",
                                  isObscure: true,
                                  errorText: state.confirmPasswordError,
                                  onChange: (confirmPassword) {
                                    context.read<SignUpBloc>().add(
                                          ConfirmPasswordChanged(
                                              confirmPassword: confirmPassword),
                                        );
                                  },
                                  controller: confirmPasswordController,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SubmitButton(
                                        label: "Create Account",
                                        submitAction: () async {
                                          final authResponse =
                                              await UserAuthentication.signup(
                                                  state.email, state.password);
                                          usernameController.clear();
                                          emailController.clear();
                                          passwordController.clear();
                                          confirmPasswordController.clear();
                                          switch (authResponse) {
                                            case "user exists":
                                              {
                                                print(
                                                    'User Exists Case checked');
                                                context.read<SignUpBloc>().add(
                                                      FireUserExists(),
                                                    );
                                              }
                                              break;
                                            case "user":
                                              {
                                                context.read<SignUpBloc>().add(
                                                      AttemptSignUp(
                                                        email: state.email,
                                                        password: state,
                                                        confirmPassword: state
                                                            .confirmPassword,
                                                      ),
                                                    );
                                              }
                                              break;
                                            default:
                                              {
                                                print('Register Failed');
                                              }
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
                                'Sign Up',
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                      child: Text("Login"),
                      onTap: () {
                        Navigator.pushNamed(context, "/login");
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
