import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:assessment/models/check_in_model.dart';
import 'package:assessment/screens/widgets/snackbar.dart';
import 'package:assessment/utils/service_result.dart';
import 'package:assessment/utils/utils.dart';

import '../../helpers/app_navigations/app_routes.dart';
import '../../helpers/app_navigations/navigation_helper.dart';

import '../../helpers/global_state/user_store.dart';
import '../../models/retailer_model.dart';
import 'check_in_screen_model.dart';

class RetailerCheckInScreenVM extends RetailerCheckinScreenModel {
  void fetchRetailers() async {
    try {
      var res = await localStorageService.getRetailers();
      if (res.statusCode == StatusCode.success) {
        setRetailers(res.data!);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> storeRetailerCheckInAgainstUser(String retailerId) async {
    try {
      var checkIn = CheckIn(
          id: generateUuid(code: 'checkIn'),
          checkInTime: DateTime.now(),
          retailerId: retailerId,
          userId: UserSingleton.instance.store.user!.id ?? "");
      var res = await localStorageService.createCheckIn(checkIn);
      if (res.statusCode == StatusCode.success) {
        await storeCheckInStatusInSharedPref();
        navigateToProductsScreen();
      } else {
        showSnackbar(res.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> storeCheckInStatusInSharedPref() async {
    try {
      var res = await sharedPreferenceService.storeUserId(
          AppConstants.checkInKey, 'true');
      if (res.statusCode != StatusCode.success) {
        showSnackbar(res.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void handleRetailerCheckin(Retailer retailer) async {
    try {
      setIsLoading(true);
      await fetchUserLocation();
      getDistanceBetweenLocations(retailer);
      setIsLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchUserLocation() async {
    try {
      var res = await deviceLocationService.getLocationDetails();
      UserSingleton.instance.store.user!.latitude = res.data!.$1;
      UserSingleton.instance.store.user!.longitude = res.data!.$2;
    } catch (e) {
      print(e.toString());
    }
  }

  void getDistanceBetweenLocations(Retailer retailer) async {
    try {
      var minDistance = 50;
      var res = deviceLocationService.calculateDistance(
          UserSingleton.instance.store.user!.latitude!,
          UserSingleton.instance.store.user!.longitude!,
          retailer.latitude!,
          retailer.longitude!);
      if (res.statusCode == StatusCode.success) {
        if (res.data <= minDistance) {
          await storeRetailerCheckInAgainstUser(retailer.id!);
        } else {
          showSnackbar('Please stay in 50m range of the retailer');
        }
      } else {
        showSnackbar(res.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToProductsScreen() {
    try {
      navigationSink.add(Navigation(
          navigationType: NavigationType.Push,
          appRoute: AppRoute.productScreen));
    } catch (e) {
      print(e.toString());
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
      var isLocationAccessPermitted = await requestLocationAccessPermission();

      if (isLocationAccessPermitted) {
        var coordinates = await fetchLatAndLongOfTheRetailer();
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

  void navigateToRetailerSignUpScreen() {
    try {
      navigationSink.add(Navigation(
          navigationType: NavigationType.Push,
          appRoute: AppRoute.retailerSignupScreen));
    } catch (e) {
      print(e.toString());
    }
  }
}
