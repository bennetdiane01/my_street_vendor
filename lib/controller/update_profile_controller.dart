import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_street_vendor/controller/vendor_online.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';

class UpdateProfileController extends GetxController{

  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressNoController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final VendorOnlineController vendorOnlineController = Get.find();
  final box = GetStorage();

  @override
  void onInit() {

    fullnameController.text = vendorOnlineController.vendorModel.value.data![0].fullName!;
    phoneController.text = vendorOnlineController.vendorModel.value.data![0].phone!;
    addressNoController.text = vendorOnlineController.vendorModel.value.data![0].locationAddress!;
    countryController.text =vendorOnlineController.vendorModel.value.data![0].country!;
    cityController.text = vendorOnlineController.vendorModel.value.data![0].city!;
    stateController.text = vendorOnlineController.vendorModel.value.data![0].state!;

    super.onInit();
  }

  void updateProfile() async{
    Get.dialog(const Center(child: CircularProgressIndicator()));

    final res = await
    client.from('vendor')
        .update({ 'full_name':  fullnameController.text.trim(),
      'country' : countryController.text.trim(),
      'location_address' : addressNoController.text.trim(),
      'city' : cityController.text.trim(),
      'state': stateController.text.trim(),
    })
        .match({ 'phone': box.read('phone'),})
        .execute();
    debugPrint('${res.data}');

    if (res.error != null) {
    //close dialog
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: const Text('Unable to update'),
            backgroundColor: colorRed,));

    }else{
      //close dialog
      Get.back();
      await  Future.delayed(const Duration(milliseconds: 900));
      //go back to update profile
      Get.back();

    }

  }

  @override
  void onClose() {
vendorOnlineController.getUserProfile();
    super.onClose();
  }
}