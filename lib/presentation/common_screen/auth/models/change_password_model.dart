class ChangePasswordInputModel {
  String? custcd;
  String? oldPass;
  String? newPass;

  ChangePasswordInputModel({this.custcd, this.oldPass, this.newPass});

  factory ChangePasswordInputModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordInputModel(
        custcd: json["custcd"],
        oldPass: json["old_pass"],
        newPass: json["new_pass"],
      );

  Map<String, dynamic> toJson() => {
    "custcd": custcd,
    "old_pass": oldPass,
    "new_pass": newPass,
  };
}
