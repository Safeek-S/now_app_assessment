import 'package:assessment/helpers/app_navigations/navigation_helper.dart';
import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:assessment/helpers/constants/app_styles.dart';
import 'package:assessment/screens/user_signup_screen/user_signup_screen_vm.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({
    super.key,
  });

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  final SignUpScreenVM signUpScreenVM = SignUpScreenVM();

  @override
  void initState() {
    super.initState();

    signUpScreenVM.navigationStream.listen((event) {
      switch (event.navigationType) {
        case NavigationType.Pop:
          Navigator.pop(context);
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Observer(builder: (
        context,
      ) {
        return signUpScreenVM.isLoading
            ? const Center(child:  CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.09,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff222222),
                              fontSize: 24),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.03),
                        child: const Text('Sign up to your new account',
                            style: TextStyle(
                                color: Color(0xff888888), fontSize: 16)),
                      ),
                      UserSignUpFormScreen(
                        signUpScreenVM: signUpScreenVM,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.015, bottom: height * 0.05),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              Observer(builder: (
                                context,
                              ) {
                                return TextButton(
                                    onPressed:
                                        signUpScreenVM.navigateToLoginScreen,
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(
                                          color: Color(0xff6200EE),
                                          fontSize: 16),
                                    ));
                              })
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}

class UserSignUpFormScreen extends StatefulWidget {
  final SignUpScreenVM signUpScreenVM;

  const UserSignUpFormScreen({super.key, required this.signUpScreenVM});

  @override
  State<UserSignUpFormScreen> createState() => _UserSignUpFormScreenState();
}

class _UserSignUpFormScreenState extends State<UserSignUpFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      widget.signUpScreenVM.signUpUser(name, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Observer(builder: (
      context,
    ) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: AppStyle.labelTextStyle,
            ),
            SizedBox(
              height: height * 0.011,
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              validator: widget.signUpScreenVM.validateUserName,
            ),
            SizedBox(
              height: height * 0.011,
            ),
            Text(
              AppConstants.emailLabel,
              style: AppStyle.labelTextStyle,
            ),
            SizedBox(
              height: height * 0.011,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              validator: widget.signUpScreenVM.validateUserEmail,
            ),
            SizedBox(
              height: height * 0.011,
            ),
            Text(
              AppConstants.passwordLabel,
              style: AppStyle.labelTextStyle,
            ),
            SizedBox(
              height: height * 0.011,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true, // Hide password characters
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              validator: widget.signUpScreenVM.validateUserPassword,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(367, 55)),
              onPressed: _handleSignup,
              child: const Text(
                'Sign Up',
              ),
            ),
          ],
        ),
      );
    });
  }
}
