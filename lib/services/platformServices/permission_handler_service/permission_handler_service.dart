import 'package:assessment/utils/service_result.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  Future<ServiceResult<bool>> requestLocationPermission() async {
    try {
          final locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus == PermissionStatus.granted) {
      // Permission granted
      return ServiceResult(StatusCode.success, 'Permission Granted', true);
    } else if (locationStatus == PermissionStatus.permanentlyDenied) {
      // Permission permanently denied, you can open settings page to open app settings
      await openAppSettings();
      return ServiceResult(StatusCode.success, 'User denied permission', true);
    } else {
      // Permission denied or other status
    }
    return ServiceResult(StatusCode.failure, 'Unknown', false);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), false);
    }

  }
}
