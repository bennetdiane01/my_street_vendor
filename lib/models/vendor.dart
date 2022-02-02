/// phone : ""
/// lat : ""
/// long : ""
/// business_name : ""

class Vendor {
  String? phone;
  String? lat;
  String? long;
  String? businessName;

  Vendor({
      this.phone, 
      this.lat, 
      this.long, 
      this.businessName});

  Vendor.fromJson(dynamic json) {
    phone = json["phone"];
    lat = json["lat"];
    long = json["long"];
    businessName = json["business_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["phone"] = phone;
    map["lat"] = lat;
    map["long"] = long;
    map["business_name"] = businessName;
    return map;
  }

}