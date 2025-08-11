class BaseResponseModel {
  bool? success;
  String? srno;
  String? message;

  BaseResponseModel({this.success, this.srno, this.message});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel(
        success: json["success"],
        srno: json["srno"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "srno": srno,
    "message": message,
  };
}

class BaseResponseModel1 {
  bool? status;
  String? data;
  String? message;

  BaseResponseModel1({this.status, this.message, this.data});

  factory BaseResponseModel1.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel1(
        status: json["status"],
        data: json["data"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": status,
    "data": data,
    "message": message,
  };
}

class BaseResponseModel2 {
  bool? status;
  String? message;

  BaseResponseModel2({this.status, this.message});

  factory BaseResponseModel2.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel2(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"success": status, "message": message};
}
