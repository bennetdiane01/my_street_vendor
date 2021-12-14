import 'package:get/get.dart';
import 'package:my_street_vendor/models/mapModel.dart';

class MapController extends GetxController{

  Set<Coffee> savedVendor = <Coffee>{};
  var isSaved = false.obs;

}