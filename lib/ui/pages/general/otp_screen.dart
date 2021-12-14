import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:my_street_vendor/controller/otp_controller.dart';
import 'package:my_street_vendor/ui/pages/buyers/main_menu.dart';
import 'package:my_street_vendor/ui/pages/general/register.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_menu.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';
//import 'package:supabase/supabase.dart';

//TODO convert to StatelessWidget
class OTPScreen extends StatefulWidget {
  String? phoneNumber;
  OTPScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  final controller = Get.put(OTPController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          //SizedBox(height: 2.h,),
          lottie.Lottie.asset('assets/lottie/otp.json', height: 20.h),
          SizedBox(height: 2.h,),
          Text('Verification', style: black18MediumTextStyle,textAlign: TextAlign.center,),
          SizedBox(height: 2.h,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3.h),
              child: Text('Enter the OTP Code that was sent to ${controller.box.read('phone')}', style: black16RegularTextStyle,textAlign: TextAlign.center,)),
          SizedBox(height: 8.h,),
          Container(
            height: 25.h,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: Color(0xffe6e6e6),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OTPTextField(
                  length: 6,
                  width: 90.w,
                  fieldWidth: 30,
                  style: const TextStyle(
                      fontSize: 17
                  ),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin)  {

                    controller.onComplete(pin);
                  },
                  onChanged: (pin){

                  },
                ),
                SizedBox(height: 3.h,),
                InkWell(
                  onTap: () async {
                    await client.auth.signIn(phone: controller.box.read('phone')).whenComplete(() {
                    });
                    debugPrint ('otp send');
                  },
                  child: Text(
                    'Resend OTP',
                    style: black16MediumTextStyle.copyWith(color: colorRed),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //Error dialog
  _errorDialog(title, content){
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: title,
          contentText: content,
          onPositiveClick: () {
            Navigator.of(context).pop();
          },
          /*onNegativeClick: () {
            Navigator.of(context).pop();
          },*/
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
}
