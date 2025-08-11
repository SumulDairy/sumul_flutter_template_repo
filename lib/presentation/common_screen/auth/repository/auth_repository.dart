import 'package:sumul_hr/common/model/baseresponse_model.dart';
import 'package:sumul_hr/presentation/common_screen/auth/models/auth_model.dart';
import 'package:sumul_hr/presentation/common_screen/auth/models/change_password_model.dart';
import 'package:sumul_hr/services/http_service/endpoint.dart';
import 'package:sumul_hr/services/http_service/http_network.dart';
import 'package:sumul_hr/utils/app_enums.dart';

class AuthRepository {
  Future<SendOtpResponseModel?> sendOtpServiceCall(String empCode) async {
    return await ApiService.request<SendOtpResponseModel>(
      path: ServiceEndPoint.sendOtp + empCode,
      method: HttpMethod.get,
      fromJson: (json) => SendOtpResponseModel.fromJson(json),
    );
  }

  Future<BaseResponseModel1?> changePasswordServiceCall({
    ChangePasswordInputModel? input,
  }) async {
    return await ApiService.request<BaseResponseModel1>(
      path: ServiceEndPoint.changePassword,
      method: HttpMethod.post,
      data: input,
      fromJson: (json) => BaseResponseModel1.fromJson(json),
    );
  }
}
