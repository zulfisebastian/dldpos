import '../../constants/endpoints.dart';
import '../../models/base/base_result.dart';
import '../../models/global/banner_model.dart';
import '../base/base_repo.dart';

class GlobalRepo extends BaseRepo {
  Future<BannerListResponse> getBanners(dynamic body) async {
    BaseResult response = await get(Endpoint.banner, queryParameters: body);
    switch (response.status) {
      case ResponseStatus.Success:
        return BannerListResponse.fromJson(response.data);
      default:
        return BannerListResponse.fromJson(response.data);
    }
  }

  Future<BannerResponse> getBannerDetail(String id) async {
    BaseResult response =
        await get(Endpoint.bannerDetail.replaceAll("{id}", id));
    switch (response.status) {
      case ResponseStatus.Success:
        return BannerResponse.fromJson(response.data);
      default:
        return BannerResponse.fromJson(response.data);
    }
  }
}
