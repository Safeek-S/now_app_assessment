
import 'package:assessment/screens/products_screen/products_screen_vm.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants/app_constants.dart';
import '../../helpers/global_state/products_store.dart';

class ProductListBuilder extends StatelessWidget {
  final ProductsScreenVM productsScreenVM;
  const ProductListBuilder({super.key,  required this.productsScreenVM});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
          ),
          itemCount: ProductStoreSingleton.instance.store.products!.length,
          itemBuilder: (context, index) {
            final product =
                ProductStoreSingleton.instance.store.products![index];
            return GestureDetector(
              onTap: () {
                productsScreenVM.addProductToCart(product.prodId!);
              
              },
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            AppConstants.productImagePath,
                            width: double.infinity,
                            height:height * 0.8,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.016,left: width * 0.01),
                        child: Text(
                          product.prodName!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xff91919F),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                       padding: EdgeInsets.only(
                            top: height * 0.01,left: width * 0.01),
                        child: Text(
                          'Rs. ${product.prodRkPrice!.toStringAsFixed(2)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}