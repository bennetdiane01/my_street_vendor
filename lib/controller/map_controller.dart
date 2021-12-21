import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_street_vendor/models/mapModel.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:supabase/supabase.dart';

class MapController extends GetxController{

  Set<Coffee> savedVendor = <Coffee>{};
  var isSaved = false.obs;
  final box = GetStorage();

  List vendor = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }


  void getAllVendor() async{

    var res = await client
        .from('vendor')
        .select()
        .execute();

    debugPrint('${res.data}');



  }




  void favouriteVendor (String vendorPhone) async{

    var checking = await client
        .from('vendor')
        .select("phone")
        .eq('phone', vendorPhone)
        .execute();

    debugPrint('${checking.toJson()}');



  }

  void addFavourite(String vendorPone) async{
    await client
        .from('favorite')
        .insert([
      {'vendor_phone': vendorPone,
        'buyer_phone': box.read('phone')
      }
    ]).execute();

    isSaved.value = true;

  }

  void removeFavourite(String vendorPone) async{

    final res = await client
        .from('favorite')
        .delete()
        .match({ 'vendor_phone': vendorPone })
        .execute();

    isSaved.value = true;

  }



}