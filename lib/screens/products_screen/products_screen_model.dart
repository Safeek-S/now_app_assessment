import 'package:assessment/screens/widgets/popup.dart';
import 'package:assessment/screens/widgets/snackbar.dart';
import 'package:assessment/services/platformServices/localStorageService/local_storage_service.dart';

import 'package:mobx/mobx.dart';

import '../../helpers/app_navigations/navigation_helper.dart';
import '../../services/api_services/product_api_service.dart';
part 'products_screen_model.g.dart';

class ProductsScreenModel extends _ProductsScreenModel
    with _$ProductsScreenModel, NavigationMixin, SnackBarMixin, PopupMixin {}

abstract class _ProductsScreenModel with Store {
  ProductApiService productApiService = ProductApiService();
  LocalStorageService localStorageService = LocalStorageService();

  @observable
  bool isLoading = false;
  @action
  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }


}
