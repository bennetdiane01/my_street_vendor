import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_street_vendor/models/favorite_list.dart';
import 'package:my_street_vendor/models/favorite_model.dart';
import 'package:my_street_vendor/models/mapModel.dart';
import 'package:my_street_vendor/models/user_data.dart';
import 'package:my_street_vendor/models/vendor_model.dart' ;
import 'package:my_street_vendor/ui/shared/variables.dart';
import 'package:supabase/supabase.dart';
import 'dart:ui' as ui;

class MapController extends GetxController{

  Set<Datum> savedVendor = <Datum>{};
  var isSaved = false.obs;
  final box = GetStorage();
  GoogleMapController? _controller;
  final showBottomSheet = false.obs;

  final vendor = <Datum>[].obs;
  List<Datum> tempVendorList = [];
  final allMarkers = <Marker>[].obs;
  final singleVendor = Datum().obs;

  final favoriteList = <FavoriteModel>[].obs;

  final buyerModel = UserData().obs;



  @override
  void onInit() {
    streamVendor();
   getAllFavoriteVendor();
    getUserProfile();
    super.onInit();


  }


  void getUserProfile() async{
    final res = await
    client.from('userDetails')
        .select()
        .match({ 'phone': box.read('phone'),})
        .execute();

    debugPrint('List of users ${res.toJson()}');
    buyerModel.value =   UserData.fromJson(res.toJson());

    /*debugPrint('${buyerModel.value.}');

    update();*/












  }


  void getAllFavoriteVendor() async{
    
    var res = await client
        .from('favorite')
        .select('''
    vendor_phone,
    vendor (
      phone,
      lat, long, business_name
    )
  ''')
    .eq('buyer_phone', box.read('phone'))
        .execute();

    debugPrint(' All favorite vendors ${res.data}');

    var result = FavoriteList.fromJson(res.data);


    favoriteList.assignAll(result.favorite!);

    debugPrint('${favoriteList.length}');




  }

  void streamVendor() async{
//TODO close stream

    var res = client.from('vendor')
        .stream()
        .execute()
        .listen((event) {
          tempVendorList.clear();
      event.forEach((element) {
        final vens = Datum.fromJson(element);


        tempVendorList.add(vens);

        vendor.assignAll(tempVendorList.where((element) => element.status==1));

        debugPrint('${vendor.length}');

      });
      setMarkers();
    });






    /*await client
        .from('vendor')
        .select()
    .match({ 'status': 1,})
        .execute();*/



    //  final vens = VendorModel.fromJson(res);

    // vendor.assignAll(vens.data!.where((element) => element.status == 1));
    /* final subscription = client
        .from('vendor')
        .on(SupabaseEventTypes.all, (payload) {
      // Handle realtime payload
      print(('Update received! ${payload.newRecord}'));

      final vens = VendorModel.fromJson(payload.newRecord);

      vendor.assignAll(vens.data!.where((element) => element.status == 1));


    })
        .subscribe();*/



   // setMarkers();








  }


  void setMarkers(){
    vendor.forEach((element) async {
      final Uint8List markerIcon = await getBytesFromAsset('assets/images/vendor.png', 100);

      allMarkers.add(
          Marker(
              markerId: MarkerId(element.businessName!),
              onTap: () {

                var target =  covertStringToLatLng(element.lat!, element.long!);
                moveCamera1(target);
                showBottomSheet(true);
                singleVendor.value = element;
              },
              icon: BitmapDescriptor.fromBytes(markerIcon),
              draggable: false,
              infoWindow:
              InfoWindow(title: element.businessName, snippet: element.address),
              position:  covertStringToLatLng(element.lat!, element.long!)));
    });
  }

  LatLng covertStringToLatLng(String lat, String long){
    double? vLat = double.tryParse(lat);
    double? vLong = double.tryParse(long);
    var target = LatLng(vLat!, vLong!);
    return target;


  }

  void mapCreated(controller) {
   _controller = controller;
   update();
  }

  moveCamera1(target) {

    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: target,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  




  void favouriteVendor (String vendorPhone) async{

    if (isSaved.value) {
      savedVendor
          .remove(singleVendor.value);
      removeFavourite(vendorPhone);
      isSaved.value = false;
      debugPrint('removed');

    } else{
      savedVendor.add(
          singleVendor.value);
      addFavourite(vendorPhone);
      isSaved.value =true;
    }

    /*var checking = await client
        .from('favorite')
        .insert([{
      'vendor_phone': vendorPhone,
      'buyer_phone': box.read('phone')
    }])
        .execute();

    debugPrint('${checking.toJson()}');
*/


  }

  void addFavourite(String vendorPone) async{
    await client
        .from('favorite')
        .insert([
      {'vendor_phone': vendorPone,
        'buyer_phone': box.read('phone')
      }
    ]).execute();



  }

  void removeFavourite(String vendorPone) async{

    final res = await client
        .from('favorite')
        .delete()
        .match({ 'vendor_phone': vendorPone })
        .execute();



  }



}