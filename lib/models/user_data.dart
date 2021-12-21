/// id : 41
/// full_name : ""
/// id_doc_id : null
/// address : ""
/// country : ""
/// state : ""
/// city : ""
/// account_type : ""
/// is_verify : 1
/// created_at : ""
/// user_id : null
/// phone : ""

class UserData {
  int? id;
  String? fullName;
  dynamic? idDocId;
  String? address;
  String? country;
  String? state;
  String? city;
  String? accountType;
  int? isVerify;
  String? createdAt;
  dynamic? userId;
  String? phone;

  UserData({
      this.id, 
      this.fullName, 
      this.idDocId, 
      this.address, 
      this.country, 
      this.state, 
      this.city, 
      this.accountType, 
      this.isVerify, 
      this.createdAt, 
      this.userId, 
      this.phone});

  UserData.fromJson(dynamic json) {
    id = json["id"];
    fullName = json["full_name"];
    idDocId = json["id_doc_id"];
    address = json["address"];
    country = json["country"];
    state = json["state"];
    city = json["city"];
    accountType = json["account_type"];
    isVerify = json["is_verify"];
    createdAt = json["created_at"];
    userId = json["user_id"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["full_name"] = fullName;
    map["id_doc_id"] = idDocId;
    map["address"] = address;
    map["country"] = country;
    map["state"] = state;
    map["city"] = city;
    map["account_type"] = accountType;
    map["is_verify"] = isVerify;
    map["created_at"] = createdAt;
    map["user_id"] = userId;
    map["phone"] = phone;
    return map;
  }

}