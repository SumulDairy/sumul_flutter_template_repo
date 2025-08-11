import 'package:sumul_hr/presentation/common_screen/drawer/aboutus/model/aboutus_model.dart';
import 'package:sumul_hr/services/http_service/endpoint.dart';
import 'package:sumul_hr/services/http_service/http_network.dart';
import 'package:sumul_hr/utils/app_enums.dart';

class AboutusRepository {
  Future<AboutUsResponseModel?> getAboutUsServiceCall({
    String? categori,
  }) async {
    return await ApiService.request<AboutUsResponseModel>(
      path: "${ServiceEndPoint.getAboutUs}?ctype=$categori",
      method: HttpMethod.get,
      fromJson: (json) => AboutUsResponseModel.fromJson(json),
    );
  }
}
