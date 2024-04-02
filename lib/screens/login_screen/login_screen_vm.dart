import 'package:assessment/helpers/app_navigations/app_routes.dart';
import 'package:assessment/helpers/app_navigations/navigation_helper.dart';
import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:assessment/screens/login_screen/login_screen_model.dart';
import 'package:assessment/utils/service_result.dart';
import 'package:assessment/utils/utils.dart';

import '../../helpers/global_state/user_store.dart';
import '../widgets/snackbar.dart';

class LoginScreenVM extends LoginScreenModel {
  void isUserLoggedIn() async {
    try {
      var res = await sharedPreferenceService.getUserId(AppConstants.userKey);
      if (res.statusCode == StatusCode.success && res.data != null) {
        await fetchUser(res.data!);
      }
    } catch (e) {
      print(e.toString());
    }
  }

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

  Future<void> fetchUser(String userId) async {
    try {
      var result = await localStorageService.findUserById(userId);
      if (result.statusCode == StatusCode.success) {
        UserSingleton.instance.store.setUser(result.data!);
        if (await didUserCheckInRetailer()) {
          navigateToProductsScreen();
        } else {
          navigateToRetailerCheckinScreen();
        }
      } else {
        showSnackbar(result.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> didUserCheckInRetailer() async {
    try {
      var res =
          await sharedPreferenceService.getUserId(AppConstants.checkInKey);
      if (res.statusCode == StatusCode.success && res.data!= null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
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

  Future<void> storeUserInSharedPref(String userId) async {
    try {
      var res = await sharedPreferenceService.storeUserId(
          AppConstants.userKey, userId);
      if (res.statusCode == StatusCode.success) {
        navigateToRetailerCheckinScreen();
      } else {
        showSnackbar(res.message);
      }
    } catch (e) {}
  }

  Future<void> loginUser(String email, String password) async {
    try {
      var result = await localStorageService.findUserByEmail(email);
      if (result.statusCode == StatusCode.success) {
        UserSingleton.instance.store.user = result.data!;
        if (UserSingleton.instance.store.user != null) {
          if (UserSingleton.instance.store.user!.password == password) {
            await fetchLocationAccessPermission();
          } else {
            showSnackbar('Password mismatch');
          }
        } else {
          showSnackbar('User not found');
        }
      } else {
        showSnackbar(result.message);
      }
    } catch (e) {
      // return false;
      print(e.toString());
    }
  }

  Future<void> fetchLocationAccessPermission() async {
    try {
      var isLocationAccessProvided = await requestLocationAccessPermission();
      if (isLocationAccessProvided) {
        var coordinates = await fetchLatAndLongOfTheRetailer();
        UserSingleton.instance.store.user!.latitude =
            coordinates!.entries.first.value;
        UserSingleton.instance.store.user!.longitude =
            coordinates.entries.last.value;

        await storeUserInSharedPref(UserSingleton.instance.store.user!.id!);
        UserSingleton.instance.store
            .setUser(UserSingleton.instance.store.user!);
      }
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

  void navigateToSignUpScreen() {
    try {
      navigationSink.add(Navigation(
          navigationType: NavigationType.Push,
          appRoute: AppRoute.signUpScreen));
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToRetailerCheckinScreen() {
    try {
      navigationSink.add(Navigation(
          navigationType: NavigationType.PushReplacement,
          appRoute: AppRoute.retailerCheckinScreen));
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToProductsScreen() {
    try {
      navigationSink.add(Navigation(
          navigationType: NavigationType.PushReplacement,
          appRoute: AppRoute.productScreen));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, double>?> fetchLatAndLongOfTheRetailer() async {
    try {
      Map<String, double> locationCoordinates = {};
      var res = await deviceLocationService.getLocationDetails();
      if (res.statusCode == StatusCode.success) {
        locationCoordinates['lat'] = res.data!.$1;
        locationCoordinates['long'] = res.data!.$2;

        return locationCoordinates;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
