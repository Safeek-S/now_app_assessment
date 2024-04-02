import 'package:assessment/helpers/app_navigations/navigation_helper.dart';

import 'package:assessment/models/user_model.dart';
import 'package:assessment/screens/user_signup_screen/user_signup_screen_model.dart';
import 'package:assessment/utils/service_result.dart';
import 'package:assessment/utils/utils.dart';

import '../widgets/snackbar.dart';

class SignUpScreenVM extends SignUpScreenModel {
  String? validateUserPassword(String? value) {
    try {
      var result = Validator().emptyFieldValidator(value);
      if (result != null) {
        setFieldErrorMessages('password', result);
        return fieldErrorMessages['password'];
      } else {
        clearErrorMessage('password');
        return result;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String? validateUserName(String? value) {
    try {
      var result = Validator().emptyFieldValidator(value);
      if (result != null) {
        setFieldErrorMessages('name', result);
        return fieldErrorMessages['name'];
      } else {
        clearErrorMessage('name');
        return result;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String? validateUserEmail(String? value) {
    try {
      var result = Validator().emailValidator(value);
      if (result != null) {
        setFieldErrorMessages('email', result);
        return fieldErrorMessages['email'];
      } else {
        clearErrorMessage('email');
        return result;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void signUpUser(String name, String email, String password) async {
    try {

      setIsLoading(true);
      User user = User(
          id: generateUuid(code: 'user'),
          createdAt: DateTime.now(),
          email: email,
          password: password,
          name: name);
      var res = await localStorageService.createUser(user);
      if (res.statusCode == StatusCode.success) {
        setIsLoading(false);
        navigateToLoginScreen();
        
      } else {
        showSnackbar(res.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToPreviousScreen() {
    try {
      navigationSink.add(Navigation(navigationType: NavigationType.Pop));
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToLoginScreen() {
    try {
      navigationSink.add(Navigation(navigationType: NavigationType.Pop));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> requestLocationAccessPermission() async {
    try {
      var res = await permissionHandlerService.requestLocationPermission();

      if (res.statusCode == StatusCode.success) {
        return res.data;
      } else {
        showSnackbar('please provide location access');
        return res.data;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void showSnackbar(String message) {
    try {
      snackBarSink.add(SnackBarEvent(message: message, actionLabel: ''));
    } catch (e) {
      print(e.toString());
    }
  }
}
