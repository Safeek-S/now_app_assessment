import 'package:assessment/helpers/app_navigations/app_routes.dart';
import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:assessment/helpers/global_state/cart_store.dart';
import 'package:assessment/helpers/global_state/products_store.dart';
import 'package:assessment/helpers/global_state/user_store.dart';
import 'package:assessment/screens/cart_screen/cart_screen_model.dart';
import 'package:assessment/utils/service_result.dart';

import '../../helpers/app_navigations/navigation_helper.dart';
import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../widgets/popup.dart';
import '../widgets/snackbar.dart';

class CartScreenVM extends CartScreenModel {
  Product? findProductById(int productId) {
    try {
      return ProductStoreSingleton.instance.store.products!
          .firstWhere((product) => product.prodId == productId);
    } catch (e) {
      return null;
    }
  }

  void incrementQuantity(Cart cartItem) async {
    try {
      cartItem.quantity = cartItem.quantity! + 1;
      await updateCartItem(cartItem);
    } catch (e) {
      print(e.toString());
    }
  }

  void decrementQuantity(Cart cartItem) async {
    try {
      int minQuantity = 1;
      if (cartItem.quantity! > minQuantity) {
        cartItem.quantity = cartItem.quantity! - 1;
        await updateCartItem(cartItem);
      } else {
        await removeProductFromCart(cartItem);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateCartItem(Cart item) async {
    try {
      var res = await localStorageService.updateCart(item);
      if (res.statusCode == StatusCode.success) {
        await fetchCartItems();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchCartItems() async {
    try {
      var res = await localStorageService.getCartItems();
      if (res.statusCode == StatusCode.success) {
        CartStoreSingleton.instance.store.setCartItems(res.data!);
      } else if (res.statusCode == StatusCode.failure) {
        CartStoreSingleton.instance.store.setCartItems([]);
      } else {}
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

  Future<void> removeProductFromCart(Cart cartItem) async {
    try {
      var res = await localStorageService.deleteCart(cartItem.id!);
      if (res.statusCode == StatusCode.success) {
        await fetchCartItems();
      } else {
        showSnackbar(res.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToPreviousScreen() {
    try {
      navigationSink.add(Navigation(navigationType: NavigationType.Pop));
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToRetailerScreen() {
    try {
      navigationSink.add(Navigation(
          navigationType: NavigationType.PushReplacement,
          appRoute: AppRoute.retailerCheckinScreen));
    } catch (e) {
      print(e.toString());
    }
  }

  void showOrderPlacedPopup(Function callback) {
    try {
      popupSink.add(
        PopupEvent(
          popupType: "Order",
            imagePath: AppConstants.orderPlacedImagePath,
            message: AppConstants.orderPlacedMessage,
            title: AppConstants.orderPlacedTitle,
            buttonOneText: 'Close',
            callbackOne: clearCheckIn),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> clearCheckIn() async {
    try {
      await removeUserCheckInFromtheLocalDb();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removeUserCheckInFromtheLocalDb() async {
    try {
      var res = await localStorageService
          .deleteUserCheckIn(UserSingleton.instance.store.user!.id!);
      if (res.statusCode == StatusCode.success) {
        await removeUserCheckInSharedPref();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> clearCart() async {
    try {
      final cartItemIds = CartStoreSingleton.instance.store.cartItems
          .map((cartItem) => cartItem.id)
          .toList();

      for (var id in cartItemIds) {
        await localStorageService.deleteCart(id!);
      }

      CartStoreSingleton.instance.store.cartItems.clear();
    } catch (e) {
      print(e.toString());
      
    }
  }

  Future<void> removeUserCheckInSharedPref() async {
    try {
      var res = await sharedPreferenceService
          .deleteFromSharedPreferences(AppConstants.checkInKey);
      if (res.statusCode == StatusCode.success) {
        await clearCart();
        navigateToRetailerScreen();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
