import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_street_vendor/models/user_detail.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';

class BuyerController extends GetxController{

  final box = GetStorage();

  final userModel = UserDetail().obs;

  @override
  void onInit() {
    getUserProfile();
    super.onInit();
  }

  void getUserProfile() async{

    final res = await
    client.from('userDetails')
        .select()
        .match({ 'phone': box.read('phone'),})
        .execute();


    debugPrint('${res.toJson()}');
    userModel.value =   UserDetail.fromJson(res.toJson());

    debugPrint('${userModel.value.data}');
    update();



  }




}