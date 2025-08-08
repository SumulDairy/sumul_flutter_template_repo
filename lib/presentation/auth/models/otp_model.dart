class DeviceCheckInputModel {
  int? mobileno;
  String? deviceid;

  DeviceCheckInputModel({this.mobileno, this.deviceid});

  factory DeviceCheckInputModel.fromJson(Map<String, dynamic> json) =>
      DeviceCheckInputModel(
        mobileno: json["mobileno"],
        deviceid: json["deviceid"],
      );

  Map<String, dynamic> toJson() => {"mobileno": mobileno, "deviceid": deviceid};
}

class DeviceCheckResponsetModel {
  bool? status;
  String? message;
  DeviceCheckResponsetData? data;

  DeviceCheckResponsetModel({this.status, this.message, this.data});

  factory DeviceCheckResponsetModel.fromJson(Map<String, dynamic> json) =>
      DeviceCheckResponsetModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DeviceCheckResponsetData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class DeviceCheckResponsetData {
  String? id;
  String? mobileno;
  String? deviceid;
  String? loginTime;

  DeviceCheckResponsetData({
    this.id,
    this.mobileno,
    this.deviceid,
    this.loginTime,
  });

  factory DeviceCheckResponsetData.fromJson(Map<String, dynamic> json) =>
      DeviceCheckResponsetData(
        id: json["id"],
        mobileno: json["mobileno"],
        deviceid: json["deviceid"],
        loginTime: json["login_time"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobileno": mobileno,
    "deviceid": deviceid,
    "login_time": loginTime,
  };
}
