import 'package:sumul_hr/di/di_helper_services.dart';
import 'package:sumul_hr/presentation/common_screen/drawer/newsalert/model/notification_model.dart';
import 'package:sumul_hr/resources/app_string.dart';
import 'package:sumul_hr/services/http_service/endpoint.dart';
import 'package:sumul_hr/services/http_service/http_network.dart';
import 'package:sumul_hr/utils/app_enums.dart';

class NotificationRepository {
  Future<NotificationResponseModel?> getNotification() async {
    var language =
        (AppServices.settings.languageCode == StringConstants.langEnglishCode)
        ? "E"
        : (AppServices.settings.languageCode ==
              StringConstants.langGujaratiCode)
        ? "G"
        : "H";
    return await ApiService.request<NotificationResponseModel>(
      path:
          "${ServiceEndPoint.getNewsAlert}${AppServices.settings.isDistributor ? AppServices.settings.selectedDistributor : AppServices.settings.selectedAgent}&lng=$language&id=${AppServices.settings.userId}",
      method: HttpMethod.get,
      fromJson: (json) => NotificationResponseModel.fromJson(json),
    );
  }

  Future<NotificationReadUnreadReponseModel?> updateNotification({
    NotificationReadUnreadInputModel? input,
  }) async {
    return await ApiService.request<NotificationReadUnreadReponseModel>(
      path: "${ServiceEndPoint.updateNotificationStatus}",
      method: HttpMethod.post,
      data: input,
      fromJson: (json) => NotificationReadUnreadReponseModel.fromJson(json),
    );
  }
}
