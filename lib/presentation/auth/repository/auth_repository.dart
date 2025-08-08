import 'package:sumul_transport/presentation/auth/models/auth_model.dart';
import 'package:sumul_transport/services/http_service/endpoint.dart';
import 'package:sumul_transport/services/http_service/http_network.dart';
import 'package:sumul_transport/utils/app_enums.dart';

class AuthRepository {
  Future<SendOtpResponseModel?> sendOtpServiceCall(String empCode) async {
    return await ApiService.request<SendOtpResponseModel>(
      path: ServiceEndPoint.sendOtp + empCode,
      method: HttpMethod.get,
      fromJson: (json) => SendOtpResponseModel.fromJson(json),
    );
  }
}
