class CommonResponseModel {
  final bool? success;
  final String? message;

  CommonResponseModel({this.success, this.message});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message};
  }
}
