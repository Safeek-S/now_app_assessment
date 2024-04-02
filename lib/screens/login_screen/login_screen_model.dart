import 'package:assessment/helpers/app_navigations/navigation_helper.dart';

import 'package:assessment/screens/widgets/snackbar.dart';
import 'package:assessment/services/platformServices/localStorageService/local_storage_service.dart';
import 'package:assessment/services/platformServices/sharedPreferenceService/sharedPreferenceService.dart';

import 'package:mobx/mobx.dart';


import '../../services/deviceServices/deviceLocationService/deviceLocationService.dart';
import '../../services/platformServices/permission_handler_service/permission_handler_service.dart';

part 'login_screen_model.g.dart';

class LoginScreenModel extends _LoginScreenModel
    with _$LoginScreenModel, NavigationMixin, SnackBarMixin {}

abstract class _LoginScreenModel with Store {
  LocalStorageService localStorageService = LocalStorageService();
  PermissionHandlerService permissionHandlerService =
      PermissionHandlerService();
  DeviceLocationService deviceLocationService = DeviceLocationService();
  SharedPreferenceService sharedPreferenceService = SharedPreferenceService();

  @observable
  Map<String, String> fieldErrorMessages = {};

  @action
  void setFieldErrorMessages(String field, String errorMessage) {
    fieldErrorMessages[field] = errorMessage;
  }

  @action
  void clearErrorMessage(String field) {
    fieldErrorMessages.remove(field);
  }
}
