import 'package:assessment/helpers/app_navigations/app_routes.dart';
import 'package:assessment/helpers/app_navigations/navigation_helper.dart';
import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:assessment/helpers/constants/app_styles.dart';
import 'package:assessment/screens/login_screen/login_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenVM _loginScreenVM = LoginScreenVM();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _loginScreenVM.isUserLoggedIn();
    _loginScreenVM.snackBarStream.listen((event) {
      if (event is SnackBarEvent) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          message: event.message,
        ));
      }
    });
    _loginScreenVM.navigationStream.listen((event) {
      switch (event.navigationType) {
        case NavigationType.Push:
          Navigator.pushNamed(context, enumToString(event.appRoute!),
                  arguments: event.data)
              .then((value) {
            _emailController.text = _passwordController.text = "";
          });

          break;
        case NavigationType.PushReplacement:
          Navigator.pushReplacementNamed(
              context, enumToString(event.appRoute!));
        default:
      }
    });
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      _loginScreenVM.loginUser(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(builder: (
          context,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.09,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.01),
                  child: Text(
                    AppConstants.loginScreenTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff222222),
                        fontSize: 24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.05),
                  child: const Text('Log In to your account',
                      style: TextStyle(color: Color(0xff888888), fontSize: 16)),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppConstants.emailLabel,
                          style: AppStyle.labelTextStyle),
                      SizedBox(
                        height: height * 0.011,
                      ),
                      Observer(builder: (context) {
                        return TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          validator: _loginScreenVM.validateUserEmail,
                        );
                      }),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Text(
                        AppConstants.passwordLabel,
                        style: AppStyle.labelTextStyle,
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Observer(builder: (context) {
                        return TextFormField(
                          controller: _passwordController,
                          obscureText: true, // Hide password characters
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          validator: _loginScreenVM.validateUserPassword,
                        );
                      }),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(367, 55)),
                        onPressed: _handleLogin,
                        child: const Text(
                          'Login',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.015),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 16),
                        ),
                        Observer(builder: (
                          context,
                        ) {
                          return TextButton(
                              onPressed: _loginScreenVM.navigateToSignUpScreen,
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Color(0xff6200EE), fontSize: 16),
                              ));
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
