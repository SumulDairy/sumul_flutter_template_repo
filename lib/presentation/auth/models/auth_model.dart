class SendOtpResponseModel {
  bool? status;
  String? message;
  SendOtpResponseData? data;

  SendOtpResponseModel({this.status, this.message, this.data});

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      SendOtpResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : SendOtpResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class SendOtpResponseData {
  String? custcd;
  String? custname;
  String? ctype;
  String? mobileno;
  bool? isdistributor;
  int? otp;

  SendOtpResponseData({
    this.custcd,
    this.custname,
    this.ctype,
    this.mobileno,
    this.otp,
    this.isdistributor,
  });

  factory SendOtpResponseData.fromJson(Map<String, dynamic> json) =>
      SendOtpResponseData(
        custcd: json["custcd"],
        custname: json["custname"],
        ctype: json["ctype"],
        mobileno: json["mobileno"],
        otp: json["otp"],
        isdistributor: json["isdistributor"],
      );

  Map<String, dynamic> toJson() => {
    "custcd": custcd,
    "custname": custname,
    "ctype": ctype,
    "mobileno": mobileno,
    "otp": otp,
    "isdistributor": isdistributor,
  };
}
