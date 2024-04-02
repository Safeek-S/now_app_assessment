import 'package:flutter/material.dart';

class ReusableScreen extends StatelessWidget {
  final String? imagePath, title,message,buttonText;
  final Function? callback;
  const ReusableScreen({super.key, this.imagePath, this.title, this.message, this.buttonText, this.callback});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return 
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.019),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            Center(child: Image.asset(imagePath!,width:width * 0.6 ,height: height* 0.4,fit: BoxFit.fill,)),
            Padding(
              padding:  EdgeInsets.only(top: height * 0.018,bottom: height * 0.018),
              child: Text(title!, style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            ),
            Text(message!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
            buttonText!=null?  ElevatedButton(onPressed: () => callback, child: Text(buttonText!)) : const SizedBox.shrink()
        
          ],
        ),
      );
   
  }
}