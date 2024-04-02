import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/utils.dart';

// class RetailerTile extends StatelessWidget {
//   final String? name;
//   final String circleAvatarWidgetType;
//   final VoidCallback onAddTap; // Callback for adding a new retailer

//   const RetailerTile({
//     required this.circleAvatarWidgetType,
//     required this.name,
//     required this.onAddTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.sizeOf(context).height * 0.9,
//       child: InkWell(
//         onTap: onAddTap,
//         child: Column(
//           // mainAxisSize: MainAxisSize.max,
//           children: [
//             circleAvatarWidgetType == 'add'
//                 ? const CircleAvatar(
//                     radius: 50,
//                     backgroundColor:
//                         Color(0xff6200EE), // Adjust color as needed
//                     child: Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 60,
//                     ),
//                   )
//                 : CircleAvatar(
//                     radius: 50,
//                     // backgroundImage, // Assuming image path
//                     child:Container(
//             decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           image: AssetImage(getImageStringFromRetailerMap(circleAvatarWidgetType)),
//           fit: BoxFit.contain, // specify the fit here
//         ),
//             ),
//           ),
//                   ),
//             Expanded(
//               // fit: FlexFit.loose,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: Text(name!, style: const TextStyle(fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
//                     ),
//                   )
               
//           ],
//         ),
//       ),
//     );
//   }
// }

class RetailerTile extends StatelessWidget {
  final String? name;
  final String circleAvatarWidgetType;
  final VoidCallback onAddTap; // Callback for adding a new retailer

  const RetailerTile({
    required this.circleAvatarWidgetType,
    required this.name,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final height =  MediaQuery.sizeOf(context).height;
    return SizedBox(
      child: InkWell(
        onTap: onAddTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              radius: height * 0.053,
              backgroundImage: circleAvatarWidgetType == 'add'
                  ? null
                  : AssetImage(getImageStringFromRetailerMap(circleAvatarWidgetType)),
              backgroundColor: circleAvatarWidgetType == 'add'
                  ? Color(0xff6200EE)
                  : Colors.transparent,
              child: circleAvatarWidgetType == 'add'
                  ? Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 60,
                    )
                  : null,
            ),
            // SizedBox(height: 10),
            Expanded(
              // fit: FlexFit.loose,
              child: Padding(
                padding:  EdgeInsets.only(top: height * 0.01),
                child: Text(
                  name!,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
