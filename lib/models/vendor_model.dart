

/// data : [{"id":2,"created_at":"","phone":"","location_address":"","lat":"","long":"","status":0,"audio":null,"business_name":"","full_name":"","country":"","state":"","city":""}]
/// status : 200
/// error : null
/// count : null

class VendorModel {
  List<Datum>? data;
  int? status;
  dynamic? error;
  dynamic? count;

  VendorModel({
      this.data, 
      this.status, 
      this.error, 
      this.count});

  VendorModel.fromJson(dynamic json) {
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(Datum.fromJson(v));
      });
    }
    status = json["status"];
    error = json["error"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    map["status"] = status;
    map["error"] = error;
    map["count"] = count;
    return map;
  }

}

/// id : 2
/// created_at : ""
/// phone : ""
/// location_address : ""
/// lat : ""
/// long : ""
/// status : 0
/// audio : null
/// business_name : ""
/// full_name : ""
/// country : ""
/// state : ""
/// city : ""

class Datum {
  int? id;
  String? createdAt;
  String? phone;
  String? address;
  String? lat;
  String? long;
  int? status;
  dynamic? audio;
  String? businessName;
  String? fullName;
  String? country;
  String? state;
  String? city;


  Datum({
    this.id,
    this.createdAt,
    this.phone,
    this.address,
    this.lat,
    this.long,
    this.status,
    this.audio,
    this.businessName,
    this.fullName,
    this.country,
    this.state,
    this.city});

  Datum.fromJson(dynamic json) {
    id = json["id"];
    createdAt = json["created_at"];
    phone = json["phone"];
    address = json["address"];
    lat = json["lat"];
    long = json["long"];
    status = json["status"];
    audio = json["audio"];
    businessName = json["business_name"];
    fullName = json["full_name"];
    country = json["country"];
    state = json["state"];
    city = json["city"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["created_at"] = createdAt;
    map["phone"] = phone;
    map["address"] = address;
    map["lat"] = lat;
    map["long"] = long;
    map["status"] = status;
    map["audio"] = audio;
    map["business_name"] = businessName;
    map["full_name"] = fullName;
    map["country"] = country;
    map["state"] = state;
    map["city"] = city;
    return map;
  }

}