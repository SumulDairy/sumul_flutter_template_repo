import 'package:sumul_transport/common/model/common_model.dart';

class BaseResponseModel extends CommonResponseModel {
  String? data;

  BaseResponseModel({this.data});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel(data: json["data"]);

  @override
  Map<String, dynamic> toJson() => {"data": data};
}
