import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorageController extends GetxController{
  final box = GetStorage();
  String? telephone;

  @override
  void onInit() {
    // TODO: implement onInit
    box;
    telephone = box.read('phone');
    super.onInit();
  }

  void getPhone(phone){
    box.write('phone', phone);
    telephone = box.read('phone');
    update();
  }

  readPhone(){
    telephone = box.read('phone');
    return telephone;
  }

}