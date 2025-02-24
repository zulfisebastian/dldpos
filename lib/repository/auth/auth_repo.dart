import '../../constants/endpoints.dart';
import '../../models/auth/login_model.dart';
import '../../models/auth/profile_model.dart';
import '../../models/base/base_result.dart';
import '../base/base_repo.dart';

class AuthRepo extends BaseRepo {
  Future<LoginResponse> postLogin(dynamic body) async {
    BaseResult response = await post(
      Endpoint.login,
      body: body,
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return LoginResponse.fromJson(response.data);
      default:
        return LoginResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<ProfileResponse> getProfile() async {
    BaseResult response = await get(
      Endpoint.profile,
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return ProfileResponse.fromJson(response.data);
      default:
        return ProfileResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }
}
