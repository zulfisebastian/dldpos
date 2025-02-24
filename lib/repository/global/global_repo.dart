import '../../constants/endpoints.dart';
import '../../models/base/base_result.dart';
import '../../models/global/banner_model.dart';
import '../../models/global/payment_model.dart';
import '../base/base_repo.dart';

class GlobalRepo extends BaseRepo {
  Future<BannerListResponse> getBanners(dynamic body) async {
    BaseResult response = await get(Endpoint.banner, queryParameters: body);
    switch (response.status) {
      case ResponseStatus.Success:
        return BannerListResponse.fromJson(response.data);
      default:
        return BannerListResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<PaymentListResponse> getPayment() async {
    BaseResult response = await get(Endpoint.payment);
    switch (response.status) {
      case ResponseStatus.Success:
        return PaymentListResponse.fromJson(response.data);
      default:
        return PaymentListResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }
}
