import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:assessment/helpers/constants/app_styles.dart';
import 'package:assessment/screens/retailer_signup_screen/retailer_signup_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../helpers/app_navigations/navigation_helper.dart';
import '../widgets/snackbar.dart';

class RetailerSignUpFormScreen extends StatefulWidget {
  const RetailerSignUpFormScreen({
    super.key,
  });

  @override
  State<RetailerSignUpFormScreen> createState() =>
      _RetailerSignUpFormScreenState();
}

class _RetailerSignUpFormScreenState extends State<RetailerSignUpFormScreen> {
  final RetailerSignUpScreenVM retailerSignUpScreenVM =
      RetailerSignUpScreenVM();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String brandName = _brandNameController.text;
      String address = _addressController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      String phoneNumber = _phoneNumberController.text;

      retailerSignUpScreenVM.signUpRetailer(
          name, email, password, brandName, address, phoneNumber);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retailerSignUpScreenVM.snackBarStream.listen((event) {
      if (event is SnackBarEvent) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          message: event.message,
        ));
      }
    });

    retailerSignUpScreenVM.navigationStream.listen((event) {
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
      appBar: AppBar(
        title: Text(
          'Add Retailer',
          style: AppStyle.screenTitleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Observer(builder: (
          context,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02,),
                  Text(
                    'Retailer Name',
                    style: AppStyle.labelTextStyle,
                  ),
                  SizedBox(
                    height: height * 0.011,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Name',
                    ),
                    validator: retailerSignUpScreenVM.validateUserName,
                  ),
                  SizedBox(
                    height: height * 0.011,
                  ),
                  Text(
                    'Brand Name',
                    style: AppStyle.labelTextStyle,
                  ),
                  SizedBox(
                    height: height * 0.011,
                  ),
                  TextFormField(
                    controller: _brandNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Brand Name',
                    ),
                    validator: retailerSignUpScreenVM.validateBrandName,
                  ),
                  SizedBox(
                    height: height * 0.011,
                  ),
                  Text(
                    'Address',
                    style: AppStyle.labelTextStyle,
                  ),
                  SizedBox(
                    height: height * 0.011,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Address',
                    ),
                    validator: retailerSignUpScreenVM.validateAddress,
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Email',
                    ),
                    validator: retailerSignUpScreenVM.validateUserEmail,
                  ),
                  SizedBox(
                    height: height * 0.011,
                  ),
                  Text(
                    'Phone Number',
                    style: AppStyle.labelTextStyle,
                  ),
                  SizedBox(
                    height: height * 0.011,
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Phone Number',
                    ),
                    validator: retailerSignUpScreenVM.validateUserPhoneNumber,
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Password',
                    ),
                    validator: retailerSignUpScreenVM.validateUserPassword,
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  ElevatedButton(
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(
                       
                        fixedSize: const Size(367, 55)),
                    child: const Text(
                      'Sign Up',
                      
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
