import 'package:assessment/database/database_helper.dart';
import 'package:assessment/helpers/constants/app_styles.dart';
import 'package:assessment/screens/cart_screen/cart_screen.dart';
import 'package:assessment/screens/check_in_screen/check_in_screen.dart';
import 'package:assessment/screens/login_screen/login_screen.dart';
import 'package:assessment/screens/retailer_signup_screen/retailer_signup_screen.dart';
import 'package:assessment/screens/user_signup_screen/user_signup_screen.dart';
import 'package:flutter/material.dart';

import 'helpers/app_navigations/app_routes.dart';
import 'screens/products_screen/products_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //  canvasColor: Colors.transparent,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: const Color.fromARGB(0, 242, 240, 240).withOpacity(0)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:AppStyle.buttonBackgroundColor, // Set background color
            foregroundColor: AppStyle.buttonTextColor, // Set text color
            // You can customize other properties here such as padding, shape, etc.
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: enumToString(AppRoute.loginScreen),
      routes: {
        // Map enum values to their corresponding routes
        enumToString(AppRoute.loginScreen): (context) => const LoginScreen(),
        enumToString(AppRoute.signUpScreen): (context) =>
            const SignUpFormScreen(),
        enumToString(AppRoute.retailerCheckinScreen): (context) =>
            const RetailerCheckinScreen(),
        enumToString(AppRoute.productScreen): (context) =>
            const ProductsScreen(),
        enumToString(AppRoute.cartScreen): (context) => const CartScreen(),
        enumToString(AppRoute.retailerSignupScreen): (context) =>
            const RetailerSignUpFormScreen()
      },
    );
  }
}
