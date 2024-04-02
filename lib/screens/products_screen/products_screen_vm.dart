import 'package:assessment/helpers/global_state/cart_store.dart';
import 'package:assessment/models/cart_model.dart';
import 'package:assessment/screens/products_screen/products_screen_model.dart';
import 'package:assessment/utils/utils.dart';

import '../../helpers/app_navigations/app_routes.dart';
import '../../helpers/app_navigations/navigation_helper.dart';
import '../../helpers/constants/app_constants.dart';
import '../../helpers/global_state/products_store.dart';
import '../../models/product_model.dart';
import '../../utils/service_result.dart';
import '../widgets/popup.dart';
import '../widgets/snackbar.dart';

class ProductsScreenVM extends ProductsScreenModel {
  Future<void> fetchProducts() async {
    try {
      setIsLoading(true);
      await fetchProductsFromLocalStorage();
      setIsLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> storeProductsInlocalDb(List<Product> products) async {
    try {
      var res = await localStorageService.storeProducts(products);
      if (res.statusCode == StatusCode.success) {
        ProductStoreSingleton.instance.store.setProducts(products);
        closePopup();
      } else {
        showSnackbar(res.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void closePopup() {
    try {
      navigationSink.add(Navigation(navigationType: NavigationType.Pop));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchProductsFromLocalStorage() async {
    try {
      var res = await localStorageService.getProducts();
      if (res.statusCode == StatusCode.success) {
        ProductStoreSingleton.instance.store.setProducts(res.data!);
      } else if (res.statusCode == StatusCode.failure ||
          res.statusCode == StatusCode.error) {
        await fetchProductsFromInternet();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchProductsFromInternet() async {
    try {
      if (await ConnectivityService.instance.checkInternetConnectivity()) {
        var res = await productApiService.fetchProductsFromInternet();
        if (res.statusCode == StatusCode.success) {
          await storeProductsInlocalDb(res.data!);
       
        }
      } else {
      
        showNoInternetPopup(fetchProducts);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addProductToCart(int productId) async {
    try {
      final existingProduct = CartStoreSingleton.instance.store.cartItems
          .where((item) => item.productId == productId)
          .isNotEmpty;
      if (existingProduct) {
        print('$productId - Already exist');
        showSnackbar('Product is already available in cart');
      } else {
        Cart cart = Cart(
            id: generateUuid(code: 'cart'), productId: productId, quantity: 1);
        await localStorageService.addToCart(cart);
        showSnackbar('Product added to the cart');
        storeCartItems();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void storeCartItems() async {
    try {
      var res = await localStorageService.getCartItems();
      if (res.statusCode == StatusCode.success) {
        CartStoreSingleton.instance.store.setCartItems(res.data!);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToCartScreen() {
    try {
      navigationSink.add(Navigation(
          navigationType: NavigationType.Push, appRoute: AppRoute.cartScreen));
    } catch (e) {
      print(e.toString());
    }
  }

  void showSnackbar(String message) {
    try {
      snackBarSink.add(SnackBarEvent(message: message, actionLabel: ''));
    } catch (e) {
      print(e.toString());
    }
  }

  void showNoInternetPopup(Function callback) {
    try {
      popupSink.add(
        PopupEvent(
          popupType: 'Internet',
            imagePath: AppConstants.noInternetImagePath,
            message: AppConstants.noInternetMessage,
            title: AppConstants.noInternetTitle,
            buttonOneText: 'Retry',
            callbackOne: callback),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
