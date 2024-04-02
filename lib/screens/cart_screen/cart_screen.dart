import 'package:assessment/helpers/constants/app_constants.dart';
import 'package:assessment/helpers/constants/app_styles.dart';
import 'package:assessment/helpers/global_state/cart_store.dart';
import 'package:assessment/screens/cart_screen/cart_screen_vm.dart';
import 'package:assessment/screens/reusables/reusable_screen.dart';
import 'package:assessment/screens/widgets/cart_items_list.dart';
import 'package:assessment/screens/widgets/popup.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import '../../helpers/app_navigations/app_routes.dart';
import '../../helpers/app_navigations/navigation_helper.dart';
import '../animation/animation_switch.dart';
import '../widgets/snackbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartScreenVM cartScreenVM = CartScreenVM();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartScreenVM.popupStream.listen((event) {
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
    cartScreenVM.snackBarStream.listen((event) {
      if (event is SnackBarEvent) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          message: event.message,
        ));
      }
    });

    cartScreenVM.navigationStream.listen((event) {
      switch (event.navigationType) {
        case NavigationType.Pop:
          Navigator.pop(
            context,
          );

          break;
        case NavigationType.PushReplacement:
          Navigator.pushReplacementNamed(
              context, enumToString(event.appRoute!));
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Observer(builder: (context) {
        return CartStoreSingleton.instance.store.cartItems.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () => cartScreenVM.showOrderPlacedPopup(cartScreenVM.clearCheckIn),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.infinity,
                              MediaQuery.sizeOf(context).height * 0.06)),
                      child: Text('Place Order')),
                ),
              )
            : SizedBox.shrink();
      }),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: () => cartScreenVM.navigateToPreviousScreen(),),
        title: Text(AppConstants.cartScreenTitle,
            style: AppStyle.screenTitleTextStyle),
      ),
      body: SingleChildScrollView(
        child: Observer(
          builder: (
            context,
          ) {
            return CartStoreSingleton.instance.store.cartItems.isNotEmpty
                ? Column(
                    children: [
                      CartItemsBuilder(cartScreenVM: cartScreenVM),
                      Card(
                        surfaceTintColor: Colors.white10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PRICE DETAILS (${CartStoreSingleton.instance.store.cartItems.length} Items)',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Divider(
                                  thickness: 2, color: Colors.black45),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total MRP",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  AnimatedSwitcherWrapper(
                                    child: Text(
                                      "\u{20B9}${CartStoreSingleton.instance.store.totalCost.toString()}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Platform Fee",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  AnimatedSwitcherWrapper(
                                    child: Text(
                                      "\u{20B9}0.00",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping Fee",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  AnimatedSwitcherWrapper(
                                    child: Text(
                                      "\u{20B9}0.00",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 2,
                                color: Colors.black45,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Amount",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  AnimatedSwitcherWrapper(
                                    child: Text(
                                      "\u{20B9} ${CartStoreSingleton.instance.store.totalCost.toString()}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,)
                    ],
                  )
                : ReusableScreen(
                    title: AppConstants.emptyCartTitle,
                    message: AppConstants.emptyCartMessage,
                    imagePath: AppConstants.emptyCartImagePath,
                  );
          },
        ),
      ),
    );
  }
}
