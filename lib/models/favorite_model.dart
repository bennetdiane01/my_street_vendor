import 'vendor.dart';

/// vendor_phone : ""
/// vendor : {"phone":"","lat":"","long":"","business_name":""}

class FavoriteModel {
  String? vendorPhone;
  Vendor? vendor;

  FavoriteModel({
      this.vendorPhone, 
      this.vendor});

  FavoriteModel.fromJson(dynamic json) {
    vendorPhone = json["vendor_phone"];
    vendor = json["vendor"] != null ? Vendor.fromJson(json["vendor"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["vendor_phone"] = vendorPhone;
    if (vendor != null) {
      map["vendor"] = vendor?.toJson();
    }
    return map;
  }

}