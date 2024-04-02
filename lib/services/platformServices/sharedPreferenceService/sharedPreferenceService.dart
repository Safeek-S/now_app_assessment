import 'package:assessment/utils/service_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {

  // Method to store user ID in SharedPreferences
  Future<ServiceResult<bool>> storeUserId(String key,String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var res = await prefs.setString(key, value);
      return ServiceResult(StatusCode.success, 'Data Stored', res);
    } catch (e) {
      print('Error storing user ID: ${e.toString()}');
      return ServiceResult(StatusCode.success, e.toString(), false);
    }
  }

  // Method to retrieve user ID from SharedPreferences
  Future<ServiceResult<String?>> getUserId(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var res = prefs.getString(key);
      return ServiceResult(StatusCode.success, 'Data returned', res);
    } catch (e) {
      print('Error retrieving user ID: ${e.toString()}');
      return ServiceResult(StatusCode.success, e.toString(), null);
    }
  }

  Future<ServiceResult<bool>> deleteFromSharedPreferences(String key) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await prefs.remove(key);
    return ServiceResult(StatusCode.success, 'Deleted Successfully', res);
  } catch (e) {
    print('Error deleting from SharedPreferences: $e');
    return ServiceResult(StatusCode.error, e.toString(), false);
    // Handle the error as needed
  }
}
}
