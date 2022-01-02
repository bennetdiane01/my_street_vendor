import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:my_street_vendor/controller/login_controller.dart';
import 'package:my_street_vendor/ui/pages/general/otp_keypad.dart';
import 'package:my_street_vendor/ui/pages/general/otp_screen.dart';
import 'package:my_street_vendor/ui/pages/general/register.dart';
import 'package:my_street_vendor/ui/pages/general/splash_screen.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_map.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_menu.dart';
import 'package:my_street_vendor/ui/shared/button.dart';
import 'package:my_street_vendor/ui/shared/randomDigits.dart';
import 'package:my_street_vendor/ui/shared/textfield.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase/supabase.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>(); // for form state key

  final LoginController controller = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Lottie.asset('assets/lottie/logo_amination.json', repeat: false, height: 15.h),
              heightSpace,
              heightSpace,
              Text('Login Page', textAlign: TextAlign.center, style: black18MediumTextStyle,),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              _txtPhone(),
              heightSpace,
              heightSpace,
              heightSpace,
              _btnLogin(),
              heightSpace,
              heightSpace,
              heightSpace,
        ],
          ),
        ),
      ),
    );
  }

  Widget _txtPhone() {
    return TextFormFieldWidget(
      hintText: "Phone e.g +13111111111",
      obscureText: false,
      enable: controller.isLoading.value ? false : true,
      textInputType: TextInputType.phone,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: controller.phoneController,
      onSubmitField: () {},
      parametersValidate: "Please an phone number.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(15),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }

  //Password
  /*Widget _txtPassword() {
    return TextFormFieldWidget(
      hintText: "Enter Password",
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: passwordController,
      onSubmitField: () {},
      parametersValidate: "Please an password.",
      txtColor: colorBlack,
      inputLength: LengthLimitingTextInputFormatter(150),
      //prefixIcon: Icon(Icons.email, color: colorBlack,),
    );
  }*/

  // for btn login
  Widget _btnLogin(){
    return Obx((){
      return InkWell(
        onTap: () async {
          //
          signIn();

        },
        child: Container(
          width: 90.w,
          height: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(child: controller.isLoading.value ? Center(child: CircularProgressIndicator()) : Text('Login/Register', style: white20SemiBoldTextStyle,)),
        ),
      );
    });
  }

  //login button
  Widget _buildNextBtn() {
    return raisedButton(
        textColor: Colors.white,
        minWidth: 500,
        text: "Next",
        leadingIcon: const Text(''),
        trailingIcon: const Text(''),
        height: 67.0,
        borderRadius: 10,
        color: primaryColor,
        borderSideColor: Colors.white,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: primaryColor,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),

        onClick: () {
          Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context) =>
              SplashScreen()), (Route<dynamic> route) => true);
        }
    );
  }

  signIn() async {

    if (_formKey.currentState!.validate()) {

      controller.login();

      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Input Phone Number'),
          backgroundColor: colorRed,),
      );

      }
    //final response = await client.auth.signUp('olawhizzy@gmail.com','1234567890');
    //final response = await client.auth.signIn(phone: '+2348166239214');
   /* final response = await client.auth.signUpWithPhone(phoneController.text, RandomDigits.getInteger(6).toString()).whenComplete(() async {
      await client.from('userDetails').insert([
        { 'phone': phoneController.text},
      ]).execute();
      await client.auth.signIn(phone: phoneController.text).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
       // _isLoading = false;
      });
      print ('otp send');
    });
    if(response.user?.phone == null){
      await client.auth.signIn(phone: phoneController.text).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
        // _isLoading = false;
      });
      return Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(phoneNumber: phoneController.text,)));
    }
    print(response.data!.user!.id);
    print(response.data!.user!.phone);
    print(response.user!.phone);
    print(response.rawData.toString());
    if (response.error != null) {
      // Error
      setState(() {
        _isLoading = false;
      });
      //_isLoading = false;
      print('Error: ${response.error?.message}');
      _errorDialog('Error', 'An error occured! \n${response.error?.message} \nPlease use your country code e.g +1111111111');
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(phoneNumber: phoneController.text,)));
    }*/
    //final response = await client.auth.signIn(phone: '+2348166239214').whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPScreen())) );
    //final response = await client.auth.signUpWithPhone('08166239214', {
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
