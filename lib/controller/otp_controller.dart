import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_street_vendor/models/user_data.dart';
import 'package:my_street_vendor/ui/pages/buyers/main_menu.dart';
import 'package:my_street_vendor/ui/pages/general/register.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_menu.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:my_street_vendor/models/user_detail.dart';
import 'package:supabase/supabase.dart';

class OTPController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;

  void onComplete(String pin) async {
    var checking = await client
        .from('userDetails')
        .select("*")
        .eq('phone', box.read('phone'))
        .execute();
    debugPrint("${checking.toJson()}");
   final userdata = UserDetail.fromJson(checking.toJson());

    if (/*checking.data[0]['is_verify']*/ userdata.data?[0].isVerify == null) {
      Get.offAll(() => Registration());
    }
    else if (userdata.data?[0].accountType == "Vendor") {

submitToVendor(userdata.data?[0]);

    } else if (userdata.data?[0].accountType == "Buyer") {
      Get.offAll(() => const MainMenu());
    }


   /* final response =
        await client.auth.verifyOTP(box.read('phone'), pin).whenComplete(() {
      debugPrint("Completed: " + pin);
    });
    if (response.error == null) {
      var checking = await client
          .from('userDetails')
          .select("*")
          .eq('phone', box.read('phone'))
          .execute();
      debugPrint("${checking.toJson()}");
      if (checking.data[0]['is_verify'] == null) {
        Get.offAll(() => Registration());
      } else {
        final session = response.data!.toJson();
        debugPrint("$session");
        //print(client.auth.currentUser!.id);
        if (checking.data['account_type'] == "Vendor") {
          Get.offAll(() => const VendorMenu());
        } else if (checking.data['account_type'] == "Buyer") {
          Get.offAll(() => const MainMenu());
        }
      }
    } else {
      debugPrint('Error: ${response.error?.message}');
      _errorDialog('Error Occured', 'Error: ${response.error?.message}');
    }*/
  }

  void submitToVendor(UserData? vendorData) async{

    var checking = await client
        .from('vendor')
        .select("*")
        .eq('phone', box.read('phone'))
        .execute(count: CountOption.exact);



    if (checking.count!>0) {
      Get.offAll(() => const VendorMenu());
    }  else {
      final res = await client
          .from('vendor')
          .insert([
        {'phone': vendorData?.phone,
          'full_name': vendorData?.fullName,
          'city': vendorData?.city,
          'country': vendorData?.country,
          'state': vendorData?.state,
          'location_address': vendorData?.address


        }
      ]).execute();
      if (res.error == null) {
        Get.offAll(() => const VendorMenu());

      } else{
        return;
      }




    }





  }

  _errorDialog(title, content) {
    return showAnimatedDialog(
      context: Get.context!,
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
