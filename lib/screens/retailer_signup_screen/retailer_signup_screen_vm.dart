import 'package:assessment/screens/retailer_signup_screen/retailer_signup_screen_model.dart';

import '../../helpers/app_navigations/navigation_helper.dart';
import '../../models/retailer_model.dart';
import '../../utils/service_result.dart';
import '../../utils/utils.dart';
import '../widgets/snackbar.dart';

class RetailerSignUpScreenVM extends RetailerSignUpScreenModel {
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

  String? validateAddress(String? value) {
    try {
      var result = Validator().emptyFieldValidator(value);
      if (result != null) {
        setFieldErrorMessages('address', result);
        return fieldErrorMessages['address'];
      } else {
        clearErrorMessage('address');
        return result;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String? validateBrandName(String? value) {
    try {
      var result = Validator().emptyFieldValidator(value);
      if (result != null) {
        setFieldErrorMessages('brand', result);
        return fieldErrorMessages['brand'];
      } else {
        clearErrorMessage('brand');
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

  String? validateUserPhoneNumber(String? value) {
    try {
      var result = Validator().phoneNumberValidator(value);
      if (result != null) {
        setFieldErrorMessages('phone', result);
        return fieldErrorMessages['phone'];
      } else {
        clearErrorMessage('phone');
        return result;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void showSnackbar(String message) {
    try {
      snackBarSink.add(SnackBarEvent(message: message, actionLabel: ''));
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

  void signUpRetailer(String name, String email, String password,
      String companyName, String address, String phoneNumber) async {
    try {
      var coordinates;
      var isLocationAccessPermitted = await requestLocationAccessPermission();

      if (isLocationAccessPermitted) {
        coordinates = await fetchLatAndLongOfTheRetailer();
        if (companyName == 'reliance') {
          coordinates = {
            'lat' : 40.7128,
            'long': 74.0060
          };
         
        } else if (companyName == "shopperstop") {
          coordinates = {
            'lat' : 35.6895,
            'long': 139.6917
          };
        } 
       

        Retailer retailer = Retailer(
            id: generateUuid(code: 'retailer'),
            email: email,
            password: password,
            name: name,
            address: address,
            companyName: companyName,
            phoneNumber: phoneNumber,
            latitude: coordinates!.entries.first.value,
            createdAt: DateTime.now(),
            longitude: coordinates.entries.last.value);
        var res = await localStorageService.createRetailer(retailer);
        if (res.statusCode == StatusCode.success) {
          navigateToPreviousScreen();
        } else {
          showSnackbar(res.message);
        }
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
}
