import 'package:assessment/screens/cart_screen/cart_screen_vm.dart';
import 'package:flutter/material.dart';

import '../../helpers/global_state/cart_store.dart';
import '../animation/animation_switch.dart';

class CartItemsBuilder extends StatelessWidget {
  final CartScreenVM cartScreenVM;
  const CartItemsBuilder({super.key, required this.cartScreenVM});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (contex, index) {
        final cartItem = CartStoreSingleton.instance.store.cartItems[index];
        final product = cartScreenVM.findProductById(cartItem.productId!);
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[200]?.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: ColorExtension.randomColor,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        'lib/resources/images/cloth.png',
                        width: 100,
                        height: 90,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        product!.prodName!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      'Rs. ${product.prodRkPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            splashRadius: 10.0,
                            onPressed: () =>
                                cartScreenVM.decrementQuantity(cartItem),
                            icon: const Icon(
                              Icons.remove,
                              color: Color(0xFF6200EE),
                            ),
                          ),
                          AnimatedSwitcherWrapper(
                            child: Text(
                              cartItem.quantity.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            splashRadius: 10.0,
                            onPressed: () =>
                                cartScreenVM.incrementQuantity(cartItem),
                            icon:
                                const Icon(Icons.add, color: Color(0xFF6200EE)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: CartStoreSingleton.instance.store.cartItems.length,
    );
  }
}
