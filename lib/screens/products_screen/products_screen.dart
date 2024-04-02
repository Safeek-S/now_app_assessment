import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:assessment/helpers/constants/app_styles.dart';
import 'package:assessment/helpers/global_state/cart_store.dart';
import 'package:assessment/helpers/global_state/products_store.dart';
import 'package:assessment/screens/products_screen/products_screen_vm.dart';
import 'package:assessment/screens/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../helpers/app_navigations/app_routes.dart';
import '../../helpers/app_navigations/navigation_helper.dart';
import '../widgets/popup.dart';
import '../widgets/snackbar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsScreenVM productsScreenVM = ProductsScreenVM();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productsScreenVM.fetchProducts();
    });

    productsScreenVM.storeCartItems();
    productsScreenVM.popupStream.listen((event) {
      if (event is PopupEvent) {
        showAdaptiveDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return CustomPopup(
                popupType: event.popupType,
                imagePath: event.imagePath,
                title: event.title,
                message: event.message,
                buttonOneText: event.buttonOneText,
                callBackOne: event.callbackOne,
              );
            });
      }
    });
    productsScreenVM.navigationStream.listen((event) {
      switch (event.navigationType) {
        case NavigationType.Push:
          Navigator.pushNamed(context, enumToString(event.appRoute!),
              arguments: event.data);

          break;
        case NavigationType.Pop:
          Navigator.pop(context);
        default:
      }
    });
    productsScreenVM.snackBarStream.listen((event) {
      if (event is SnackBarEvent) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          message: event.message,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppConstants.productsScreenTitle,
            style: AppStyle.screenTitleTextStyle),
        actions: [
          Observer(
            builder: (
              context,
            ) {
              return Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.sizeOf(context).width * 0.045,
                ),
                child: GestureDetector(
                  onTap: productsScreenVM.navigateToCartScreen,
                  child: Badge(
                    textColor: Colors.white,
                    backgroundColor: const Color(0xff6200EE),
                    label: Text(
                      CartStoreSingleton.instance.store.cartItems.length
                          .toString(),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Observer(builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.045,
          ),
          height: MediaQuery.sizeOf(context).height * 0.9,
          child: productsScreenVM.isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : (ProductStoreSingleton.instance.store.products != null &&
                      ProductStoreSingleton.instance.store.products!.isNotEmpty)
                  ? ProductListBuilder(productsScreenVM: productsScreenVM)
                  : const Center(
                      child: Text(
                      'No Products Available',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    )),
        );
      }),
    );
  }
}
