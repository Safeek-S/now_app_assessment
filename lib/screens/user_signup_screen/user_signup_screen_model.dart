import 'package:assessment/helpers/app_navigations/navigation_helper.dart';
import 'package:assessment/screens/widgets/snackbar.dart';
import 'package:assessment/services/deviceServices/deviceLocationService/deviceLocationService.dart';
import 'package:mobx/mobx.dart';

import '../../models/user_model.dart';
import '../../services/platformServices/localStorageService/local_storage_service.dart';
import '../../services/platformServices/permission_handler_service/permission_handler_service.dart';

part 'user_signup_screen_model.g.dart';

class SignUpScreenModel extends _SignUpScreenModel with _$SignUpScreenModel, NavigationMixin, SnackBarMixin{}

abstract class _SignUpScreenModel with Store {

   PermissionHandlerService permissionHandlerService = PermissionHandlerService();
  LocalStorageService localStorageService = LocalStorageService();
  DeviceLocationService deviceLocationService = DeviceLocationService();
 
  @observable
  User? user;

  @observable
  bool isLoading = false;

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

  @action
  void setUser(User user) {
    this.user = user;
  }

  
  @action
  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

}
