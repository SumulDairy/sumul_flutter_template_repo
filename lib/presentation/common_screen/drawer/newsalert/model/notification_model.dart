class NotificationModel {}

class NewsAlertItem {
  final String title;
  final String description;
  final String? link;
  final String? downloadUrl;

  NewsAlertItem({
    required this.title,
    required this.description,
    this.link,
    this.downloadUrl,
  });
}

class ApiNotificationModel {
  final int id;
  final String title;
  final String body;
  final DateTime timestamp;

  ApiNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory ApiNotificationModel.fromJson(Map<String, dynamic> json) {
    return ApiNotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class NotificationResponseModel {
  bool? status;
  String? message;
  bool? islogout;
  List<NotificationResponseData>? data;

  NotificationResponseModel({
    this.status,
    this.message,
    this.data,
    this.islogout,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationResponseModel(
        status: json["status"],
        message: json["message"],
        islogout: json["islogout"],
        data: json["data"] == null
            ? []
            : List<NotificationResponseData>.from(
                json["data"]!.map((x) => NotificationResponseData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "islogout": islogout,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationResponseData {
  int? trnNo;
  String? subject;
  String? message;
  String? entryDate;
  String? pdfFile;
  String? msgStatus;
  bool? isNew;
  String? url;
  bool? isExpanded;

  NotificationResponseData({
    this.trnNo,
    this.subject,
    this.message,
    this.entryDate,
    this.pdfFile,
    this.msgStatus,
    this.isNew,
    this.url,
    this.isExpanded,
  });

  factory NotificationResponseData.fromJson(Map<String, dynamic> json) =>
      NotificationResponseData(
        trnNo: json["TrnNo"],
        subject: json["Subject"],
        message: json["Message"],
        entryDate: json["EntryDate"],
        pdfFile: json["PdfFile"],
        msgStatus: json["MsgStatus"],
        isNew: json["IsNew"],
      );

  Map<String, dynamic> toJson() => {
    "TrnNo": trnNo,
    "Subject": subject,
    "Message": message,
    "EntryDate": entryDate,
    "PdfFile": pdfFile,
    "MsgStatus": msgStatus,
    "IsNew": isNew,
  };
}

//INput Model

class NotificationReadUnreadInputModel {
  String? custcd;
  String? trnno;

  NotificationReadUnreadInputModel({this.custcd, this.trnno});

  factory NotificationReadUnreadInputModel.fromJson(
    Map<String, dynamic> json,
  ) => NotificationReadUnreadInputModel(
    custcd: json["custcd"],
    trnno: json["trnno"],
  );

  Map<String, dynamic> toJson() => {"custcd": custcd, "trnno": trnno};
}

//input Response Model
class NotificationReadUnreadReponseModel {
  bool? status;
  String? message;

  NotificationReadUnreadReponseModel({this.status, this.message});

  factory NotificationReadUnreadReponseModel.fromJson(
    Map<String, dynamic> json,
  ) => NotificationReadUnreadReponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
