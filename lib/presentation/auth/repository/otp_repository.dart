import 'package:sumul_transport/presentation/auth/models/otp_model.dart';
import 'package:sumul_transport/services/http_service/endpoint.dart';
import 'package:sumul_transport/services/http_service/http_network.dart';
import 'package:sumul_transport/utils/app_enums.dart';

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
}
