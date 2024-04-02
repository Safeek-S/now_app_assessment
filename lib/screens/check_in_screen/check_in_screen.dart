import 'package:assessment/helpers/constants/app_styles.dart';
import 'package:assessment/screens/check_in_screen/check_in_screen_vm.dart';
import 'package:assessment/screens/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../helpers/app_navigations/app_routes.dart';
import '../../helpers/app_navigations/navigation_helper.dart';
import '../../helpers/constants/app_constants.dart';
import '../widgets/retailer_tile.dart';

class RetailerCheckinScreen extends StatefulWidget {
  const RetailerCheckinScreen({super.key});

  @override
  State<RetailerCheckinScreen> createState() => _RetailerCheckinScreenState();
}

class _RetailerCheckinScreenState extends State<RetailerCheckinScreen> {
  final RetailerCheckInScreenVM retailerCheckInScreenVM =
      RetailerCheckInScreenVM();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retailerCheckInScreenVM.fetchRetailers();
    retailerCheckInScreenVM.snackBarStream.listen((event) {
      if (event is SnackBarEvent) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          message: event.message,
        ));
      }
    });

    retailerCheckInScreenVM.navigationStream.listen((event) {
      switch (event.navigationType) {
        case NavigationType.Push:
          Navigator.pushNamed(context, enumToString(event.appRoute!))
              .then((value) => retailerCheckInScreenVM.fetchRetailers());

          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(AppConstants.retailersCheckInScreenTitle,
              style: AppStyle.screenTitleTextStyle),
          actions: null,
        ),
        body: Observer(
          builder: (
            context,
          ) {
            return retailerCheckInScreenVM.isLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : retailerCheckInScreenVM.retailers.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.019,
                            left: width * 0.019,
                            top: height * 0.04),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(), // Optional: Disable scrolling if needed
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Number of items per row
                                  mainAxisSpacing:
                                      10.0, // Spacing between rows (optional)
                                  crossAxisSpacing:
                                      5.0, // Spacing between columns (optional)
                                ),
                                itemCount:
                                    retailerCheckInScreenVM.retailers.length +
                                        1,
                                itemBuilder: (context, index) {
                                  if (index ==
                                      retailerCheckInScreenVM
                                          .retailers.length) {
                                    // Add tile for new retailer
                                    return RetailerTile(
                                      name: 'Add Retailer',
                                      circleAvatarWidgetType: 'add',
                                      onAddTap: retailerCheckInScreenVM
                                          .navigateToRetailerSignUpScreen,
                                    );
                                  } else {
                                    // Existing retailer tile
                                    return RetailerTile(
                                      circleAvatarWidgetType:
                                          retailerCheckInScreenVM
                                              .retailers[index].companyName!,
                                      name: retailerCheckInScreenVM
                                          .retailers[index].name,
                                      onAddTap: () => retailerCheckInScreenVM
                                          .handleRetailerCheckin(
                                              retailerCheckInScreenVM
                                                  .retailers[index]),
                                    );
                                  }
                                },
                              ),
                            ]),
                      )
                    : NoRetailersScreen(
                        callback: retailerCheckInScreenVM
                            .navigateToRetailerSignUpScreen,
                      );
          },
        ));
  }
}

class NoRetailersScreen extends StatelessWidget {
  final Function callback;
  const NoRetailersScreen({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: Text(
            'Uh, No Retailer!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.015),
          child: const Text(
            'Add a retailer to start your shopping journey',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(
          onPressed: () => callback(),
          child: const Text('Add Retailer'),
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50)),
        )
      ],
    );
  }
}
