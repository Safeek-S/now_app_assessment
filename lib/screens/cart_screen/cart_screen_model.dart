import 'package:assessment/models/product_model.dart';
import 'package:assessment/screens/widgets/popup.dart';
import 'package:assessment/screens/widgets/snackbar.dart';
import 'package:mobx/mobx.dart';

import '../../helpers/app_navigations/navigation_helper.dart';
import '../../services/platformServices/localStorageService/local_storage_service.dart';
import '../../services/platformServices/sharedPreferenceService/sharedPreferenceService.dart';
part 'cart_screen_model.g.dart';
class CartScreenModel extends _CartScreenModel with _$CartScreenModel,NavigationMixin,SnackBarMixin,PopupMixin{}

abstract class _CartScreenModel with Store {
  
  LocalStorageService localStorageService = LocalStorageService();
   SharedPreferenceService sharedPreferenceService = SharedPreferenceService();
  
  @observable
  List<Product> cartItems = [];


   @action
  void setCartItems(List<Product> products){
    cartItems = products;
  }
  
}
  
  