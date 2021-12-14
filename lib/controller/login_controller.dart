import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_street_vendor/ui/pages/general/otp_screen.dart';
import 'package:my_street_vendor/ui/shared/randomDigits.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';

class LoginController extends GetxController{


  final box = GetStorage();
  var isLoading = false.obs;
  TextEditingController phoneController = TextEditingController();


  @override
  void onInit() {
    if(box.read('phone') != null){
      phoneController.text = box.read('phone');
    }
    super.onInit();
  }

  void login() async{

    isLoading(true);
    box.write('phone', phoneController.text);
    var checking = await client.from('userDetails').select("*").eq('phone', phoneController.text).execute();
    if (checking.data.length<1) {
      final response = await client.auth.signUpWithPhone(phoneController.text, RandomDigits.getInteger(6).toString()).whenComplete(() async {
        await client.from('userDetails').insert([
          { 'phone': phoneController.text},
        ]).execute();
        await client.auth.signIn(phone: phoneController.text).whenComplete(() {
          isLoading(false);
        });
        debugPrint ('otp send');
      });

    }else{
      await client.auth.signIn(phone: phoneController.text).whenComplete(() {
        isLoading(false);
      });
      debugPrint ('otp send');

    }

    Get.to(()=> OTPScreen(phoneNumber: phoneController.text,));
  }

  void register() async{

    isLoading(true);
    box.write('phone', phoneController.text);
    final response = await client.auth.signUpWithPhone(phoneController.text, RandomDigits.getInteger(6).toString())
        .whenComplete(() async {
      await client.from('userDetails').insert([
        { 'phone': phoneController.text},
      ]).execute();
      isLoading(false);

    });

    Get.to(()=> OTPScreen(phoneNumber: phoneController.text,));







  }


}