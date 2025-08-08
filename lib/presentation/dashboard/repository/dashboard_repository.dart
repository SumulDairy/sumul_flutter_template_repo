import 'package:sumul_transport/di/di_helper_services.dart';
import 'package:sumul_transport/presentation/create_balance/model/crate_balance_model.dart';
import 'package:sumul_transport/services/http_service/endpoint.dart';
import 'package:sumul_transport/services/http_service/http_network.dart';
import 'package:sumul_transport/utils/app_enums.dart';

class DashboardRepository {
  Future<CrateTransportResponseModel?> getTransport() async {
    return await ApiService.request<CrateTransportResponseModel>(
      path: "${ServiceEndPoint.getTransport}${AppServices.settings.mobileNo}",
      method: HttpMethod.get,
      fromJson: (json) => CrateTransportResponseModel.fromJson(json),
    );
  }
}
