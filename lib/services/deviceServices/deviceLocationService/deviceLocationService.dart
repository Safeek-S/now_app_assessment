import 'package:assessment/utils/service_result.dart';
import 'package:geolocator/geolocator.dart';

class DeviceLocationService {
  Future<ServiceResult<(double, double)?>> getLocationDetails() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are disabled, request to enable
        return Future.error('Location services are disabled.');
      }

      // Check for location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          // Permission denied, inform the user
          return Future.error('Location permissions denied');
        }
      }
      // When enabled and permission granted, fetch location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return ServiceResult(StatusCode.success, 'Location fetched successfully',
          (position.latitude, position.longitude));
    } catch (e) {
      return ServiceResult(StatusCode.error, 'An error occurred', null);
    }
  }

  ServiceResult<double> calculateDistance(double userlat, double userlong,
      double retailerlat, double retailerlong) {
    try {
      double distance = Geolocator.distanceBetween(
          userlat, userlong, retailerlat, retailerlong);
      return ServiceResult(
          StatusCode.success, 'Distance is calculated', distance);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99999999999999.00);
    }
  }
}
