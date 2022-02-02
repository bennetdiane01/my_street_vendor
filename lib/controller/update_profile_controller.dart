import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_street_vendor/controller/buyer_controller.dart';
import 'package:my_street_vendor/controller/vendor_online.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';

class UpdateProfileController extends GetxController {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressNoController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final vendorOnlineController = Get.put(VendorOnlineController());
  final userController = Get.put(BuyerController());
  final box = GetStorage();

  var userData = Get.arguments;

  @override
  void onInit() {
    fullnameController.text = userData[0].fullName;
    phoneController.text = userData[0].phone;
    addressNoController.text = userData[0].address;
    countryController.text = userData[0].country;
    cityController.text = userData[0].city;
    stateController.text = userData[0].state;

    super.onInit();
  }

  void updateProfile() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));

    if (userData[1] == 'buyer') {
      await UpdateBuyerProfile();
    } else {
      await UpdateVendorProfile();
    }
  }

  Future<void> UpdateBuyerProfile() async {
    final res = await client.from('userDetails').update({
      'full_name': fullnameController.text.trim(),
      'country': countryController.text.trim(),
      'address': addressNoController.text.trim(),
      'city': cityController.text.trim(),
      'state': stateController.text.trim(),
    }).match({
      'phone': box.read('phone'),
    }).execute();
    debugPrint('${res.data}');

    if (res.error != null) {
      //close dialog
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: const Text('Unable to update'),
        backgroundColor: colorRed,
      ));
    } else {
      //close dialog
      Get.back();
      await Future.delayed(const Duration(milliseconds: 900));
      //go back to update profile
      Get.back();
    }
  }

  Future<void> UpdateVendorProfile() async {
    final res = await client.from('vendor').update({
      'full_name': fullnameController.text.trim(),
      'country': countryController.text.trim(),
      'address': addressNoController.text.trim(),
      'city': cityController.text.trim(),
      'state': stateController.text.trim(),
    }).match({
      'phone': box.read('phone'),
    }).execute();
    debugPrint('${res.data}');

    if (res.error != null) {
      //close dialog
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: const Text('Unable to update'),
        backgroundColor: colorRed,
      ));
    } else {
      //close dialog
      Get.back();
      await Future.delayed(const Duration(milliseconds: 900));
      //go back to update profile
      Get.back();
    }
  }

  @override
  void onClose() {
    vendorOnlineController.getUserProfile();
    userController.getUserProfile();
    super.onClose();
  }
}
