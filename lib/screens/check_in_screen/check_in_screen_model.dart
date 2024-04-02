import 'package:assessment/models/check_in_model.dart';
import 'package:assessment/models/retailer_model.dart';
import 'package:assessment/screens/widgets/snackbar.dart';
import 'package:assessment/services/deviceServices/deviceLocationService/deviceLocationService.dart';
import 'package:assessment/services/platformServices/localStorageService/local_storage_service.dart';
import 'package:assessment/services/platformServices/sharedPreferenceService/sharedPreferenceService.dart';
import 'package:mobx/mobx.dart';

import '../../helpers/app_navigations/navigation_helper.dart';

import '../../services/api_services/product_api_service.dart';
import '../../services/platformServices/permission_handler_service/permission_handler_service.dart';
import '../widgets/popup.dart';

part 'check_in_screen_model.g.dart';

class RetailerCheckinScreenModel extends _RetailerCheckinScreenModel
    with
        _$RetailerCheckinScreenModel,
        PopupMixin,
        NavigationMixin,
        SnackBarMixin {}

abstract class _RetailerCheckinScreenModel with Store {
  LocalStorageService localStorageService = LocalStorageService();

  ProductApiService productApiService = ProductApiService();
  DeviceLocationService deviceLocationService = DeviceLocationService();
  SharedPreferenceService sharedPreferenceService = SharedPreferenceService();

  PermissionHandlerService permissionHandlerService =
      PermissionHandlerService();


  @observable
  Retailer? retailer;

   @observable
  bool isLoading = false;
 @action
  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }


  @action
  void setRetailer(Retailer retailer) {
    this.retailer = retailer;
  }

  @observable
  List<Retailer> retailers = [];

  @observable
  CheckIn? userCheckin;

  @action
  void setRetailers(List<Retailer> retailers) {
    this.retailers = retailers;
  }

  @action
  setUserChecking(CheckIn userCheckin) {
    this.userCheckin = userCheckin;
  }

 
}
