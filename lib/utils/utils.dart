import 'dart:io';

import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:uuid/uuid.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Validator {
  RegExp emailRegEx = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+"),
      indianPhoneNumberRegEx = RegExp(r'^(\+?91|0)?[789]\d{9}$');
  String? emptyFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.emptyPasswordWarning;
    } else {
      return null;
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.emptyEmailWarning;
    } else if (!emailRegEx.hasMatch(value)) {
      return AppConstants.incorrectEmailWarning;
    } else {
      return null;
    }
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.emptyPhoneNumberWarning;
    }
    if (indianPhoneNumberRegEx.hasMatch(value)) {
      return null;
    } else {
      return AppConstants.incorrectPhoneNumberWarning;
    }
  }
}

String getImageStringFromRetailerMap(String searchString) {
  for (var entry in AppConstants.retailerImagePathMap.entries) {
    // Check if the key (entry.key) matches the searchString
    if (entry.key == searchString) {
      // Return the corresponding value if found
      return entry.value;
    }
  }
  // Return bata image if the searchString is not found in the map
  return AppConstants.retailerImagePathMap['bata']!;
}

String generateUuid({required String code}) {
  Uuid uuid = const Uuid();
  return '$code-${uuid.v4()}';
}

class ConnectivityService {
  static final ConnectivityService instance = ConnectivityService._internal();

  factory ConnectivityService() => instance;

  ConnectivityService._internal();

  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // Method to check if connected to network
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
