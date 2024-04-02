import 'package:assessment/models/retailer_model.dart';
import 'package:assessment/screens/widgets/snackbar.dart';
import 'package:assessment/services/deviceServices/deviceLocationService/deviceLocationService.dart';
import 'package:assessment/services/platformServices/localStorageService/local_storage_service.dart';
import 'package:mobx/mobx.dart';

import '../../helpers/app_navigations/navigation_helper.dart';

import '../../services/platformServices/permission_handler_service/permission_handler_service.dart';


part 'retailer_signup_screen_model.g.dart';

class RetailerSignUpScreenModel extends _RetailerSignUpScreenModel
    with
        _$RetailerSignUpScreenModel,
        NavigationMixin,
        SnackBarMixin {}

abstract class _RetailerSignUpScreenModel with Store {
  LocalStorageService localStorageService = LocalStorageService();

  DeviceLocationService deviceLocationService = DeviceLocationService();

  PermissionHandlerService permissionHandlerService =
      PermissionHandlerService();

  @observable
  Retailer? retailer;
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
  void setRetailer(Retailer retailer) {
    this.retailer = retailer;
  }


}
