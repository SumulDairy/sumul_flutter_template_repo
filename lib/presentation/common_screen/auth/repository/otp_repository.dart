import 'package:sumul_hr/common/model/baseresponse_model.dart';
import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/auth/models/otp_model.dart';
import 'package:sumul_hr/services/http_service/endpoint.dart';
import 'package:sumul_hr/services/http_service/http_network.dart';
import 'package:sumul_hr/utils/app_enums.dart';

class OtpRepository {
  Future<DeviceCheckResponsetModel?> deviceCheck({
    DeviceCheckInputModel? input,
  }) async {
    return await ApiService.request<DeviceCheckResponsetModel>(
      path: ServiceEndPoint.deviceCheck,
      method: HttpMethod.post,
      data: input,
      fromJson: (json) => DeviceCheckResponsetModel.fromJson(json),
    );
  }

  Future<BaseResponseModel2?> logoutAll() async {
    return await ApiService.request<BaseResponseModel2>(
      path: "${ServiceEndPoint.deviceLogout}${AppServices.settings.mobileNo}",
      method: HttpMethod.get,
      fromJson: (json) => BaseResponseModel2.fromJson(json),
    );
  }
}
