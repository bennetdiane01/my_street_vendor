import 'user_data.dart';

/// data : [{"id":41,"full_name":"","id_doc_id":null,"address":"","country":"","state":"","city":"","account_type":"","is_verify":1,"created_at":"","user_id":null,"phone":""}]
/// status : 200
/// error : null
/// count : null

class UserDetail {
  List<UserData>? data;
  int? status;
  dynamic? error;
  dynamic? count;

  UserDetail({
      this.data, 
      this.status, 
      this.error, 
      this.count});

  UserDetail.fromJson(dynamic json) {
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(UserData.fromJson(v));
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