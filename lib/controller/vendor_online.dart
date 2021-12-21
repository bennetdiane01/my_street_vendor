
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_street_vendor/controller/local_storage.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:supabase/supabase.dart';

class VendorOnlineController extends GetxController {

  RxBool isOnline = false.obs;

  var subscription;

  LocalStorageController localStorageController = Get.put(LocalStorageController());

  @override
  void onInit() {
    // TODO: implement onInit
    //ccc();
    //checkifRealtime();
    super.onInit();
  }
  Future<void> changeStatus() async {
    var checking = await client.from('userOnline').select("*").eq('phone', localStorageController.telephone).execute();
    var jsonResult = checking.toJson();
    /*var response = await client.from('userDetails').update(
      {
        'full_name': fullnameController.text,
        'address': addressNoController.text,
        'country': countryController.text,
        'state': stateController.text,
        'city': cityController.text,
        'account_type': account_type,
        'is_verify': 1,
      },
    ).eq('phone', phoneNumber ).execute();*/
  }
  Future<void> ccc() async {
    print('on loaddd');
    // Set up a listener to listen to changes in `countries` table
    subscription = client.from('countries').on(SupabaseEventTypes.update, (x) {
      print('on todos.insert: ${x.table} ${x.eventType} ${x.newRecord}');
    }).subscribe((String event, {String? errorMsg}) {
      print('event: $event error: $errorMsg');
    });
    // remember to remove subscription when you're done
    //client.removeSubscription(subscription);
    await client
        .from('countries')
        .stream()
        .order('name')
        .limit(10)
        .execute()
        .listen((snapshot) {
     // print('snapshot: $snapshot');
    });
  }

  void checkifRealtime() {

    client.from('vendor:status=eq.online').stream().execute().listen((event) {
      debugPrint('event: $event');
    });
  }

  void toggleOnlineStatus() async{
    Get.dialog(Center(child: const  CircularProgressIndicator()));

    if (isOnline.value) {
      final res = await
      client.from('vendor')
          .update({ 'status':  0})
          .match({ 'status': '1' })
          .execute();
      isOnline.value = false;
      debugPrint('${res.data}');
      Get.back();
    }else{
      final res = await
      client.from('vendor')
          .update({ 'status': 1 })
          .match({ 'status': 0 })
          .execute();
      isOnline.value = true;
      debugPrint('${res.data}');
      Get.back();

    }



  }

  void getUserLocation() async{


  }


  void getUserProfile() async{




  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    client.removeSubscription(subscription);
  }
}