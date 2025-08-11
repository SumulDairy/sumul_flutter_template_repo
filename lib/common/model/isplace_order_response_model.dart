class IsPlaceOrderResponseModel {
  bool? status;
  String? message;
  IsPlaceOrderResponseData? data;

  IsPlaceOrderResponseModel({this.status, this.message, this.data});

  factory IsPlaceOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      IsPlaceOrderResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : IsPlaceOrderResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class IsPlaceOrderResponseData {
  String? titleE;
  String? msgE;
  String? titleH;
  String? msgH;
  String? titleG;
  String? msgG;

  IsPlaceOrderResponseData({
    this.titleE,
    this.msgE,
    this.titleH,
    this.msgH,
    this.titleG,
    this.msgG,
  });

  factory IsPlaceOrderResponseData.fromJson(Map<String, dynamic> json) =>
      IsPlaceOrderResponseData(
        titleE: json["title_e"],
        msgE: json["msg_e"],
        titleH: json["title_h"],
        msgH: json["msg_h"],
        titleG: json["title_g"],
        msgG: json["msg_g"],
      );

  Map<String, dynamic> toJson() => {
    "title_e": titleE,
    "msg_e": msgE,
    "title_h": titleH,
    "msg_h": msgH,
    "title_g": titleG,
    "msg_g": msgG,
  };
}
