
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:my_street_vendor/controller/local_storage.dart';
import 'package:my_street_vendor/models/vendor_model.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:supabase/supabase.dart';

class VendorOnlineController extends GetxController {

  RxBool isOnline = false.obs;

  RealtimeSubscription? subscription;

  final vendorModel  = VendorModel().obs;

  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  double? latitude;
  double? longitude;
  final box = GetStorage();

  LocalStorageController localStorageController = Get.put(LocalStorageController());

  @override
  void onInit() {
    // TODO: implement onInit
    //ccc();
    //checkifRealtime();
    streamVendor();
    getUserProfile();
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

    client.from('vendor:status=eq.1').stream().execute().listen((event) {
      debugPrint('event: ${event}');
    });
  }

  void toggleOnlineStatus() async{

    Get.dialog(const Center(child: CircularProgressIndicator()));


    if (isOnline.value) {
      final res = await
      client.from('vendor')
          .update({ 'status':  0})
          .match({ 'phone': box.read('phone'),})
          .execute();
      isOnline.value = false;
      //debugPrint('${res.data}');
      Get.back();
    }
    else{
      getUserLocation();
      final res = await
      client.from('vendor')
          .update({ 'status': 1 , 'lat': '$latitude', 'long':'$longitude'})

          .match({ 'phone': box.read('phone'),})
          .execute();
      isOnline.value = true;
     // debugPrint('${res.data}');
      Get.back();

    }



  }

  void streamVendor() async{

  /* final subscription = client
        .from('vendor')
        .stream()
        .execute().listen((event) {
     print(('\n\n #############streamEvent $event'));
    });*/

    subscription = client
        .from('vendor')
        .on(SupabaseEventTypes.update, (payload) {
      // Handle realtime payload
      print(('Update received! ${payload.newRecord}'));


    })
        .subscribe();






    /*var res = await client
        .from('vendor')
        .select()
    .match({ 'status': 1,})
        .execute();

    debugPrint('${res.data}');*/

  }

  void getUserLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;
    update();


    debugPrint('the location is ${_locationData.latitude} and ${_locationData.longitude}');


  }


  void getUserProfile() async{

    final res = await
    client.from('vendor')
        .select()
        .match({ 'phone': box.read('phone'),})
        .execute();


    debugPrint('${res.toJson()}');
  vendorModel.value =   VendorModel.fromJson(res.toJson());

 debugPrint('${vendorModel.value.data}');

 update();












  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    client.removeSubscription(subscription!);
  }
}