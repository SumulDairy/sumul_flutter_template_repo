class AboutUsResponseModel {
  bool? status;
  String? message;
  String? lbl;
  List<AboutUsResponseData>? data;

  AboutUsResponseModel({this.status, this.message, this.lbl, this.data});

  factory AboutUsResponseModel.fromJson(Map<String, dynamic> json) =>
      AboutUsResponseModel(
        status: json["status"],
        message: json["message"],
        lbl: json["lbl"],
        data: json["data"] == null
            ? []
            : List<AboutUsResponseData>.from(
                json["data"]!.map((x) => AboutUsResponseData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "lbl": lbl,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AboutUsResponseData {
  String? phoneno;

  AboutUsResponseData({this.phoneno});

  factory AboutUsResponseData.fromJson(Map<String, dynamic> json) =>
      AboutUsResponseData(phoneno: json["phoneno"]);

  Map<String, dynamic> toJson() => {"phoneno": phoneno};
}
