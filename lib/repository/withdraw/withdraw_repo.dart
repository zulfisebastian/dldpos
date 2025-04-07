import 'package:dld/models/account/account_model.dart';
import 'package:dld/models/global/balance_model.dart';
import 'package:dld/models/global/withdraw_model.dart';
import '../../constants/endpoints.dart';
import '../../models/base/base_response.dart';
import '../../models/base/base_result.dart';
import '../../models/global/bank_model.dart';
import '../base/base_repo.dart';

class WithdrawRepo extends BaseRepo {
  Future<BankListResponse> getBank() async {
    BaseResult response = await get(Endpoint.bank);
    switch (response.status) {
      case ResponseStatus.Success:
        return BankListResponse.fromJson(response.data);
      default:
        return BankListResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<AccountListResponse> getMyAccount() async {
    BaseResult response = await get(Endpoint.myBank);
    switch (response.status) {
      case ResponseStatus.Success:
        return AccountListResponse.fromJson(response.data);
      default:
        return AccountListResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<AccountResponse> createAccount(dynamic body) async {
    BaseResult response = await post(Endpoint.createBank, body: body);
    switch (response.status) {
      case ResponseStatus.Success:
        return AccountResponse.fromJson(response.data);
      default:
        return AccountResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<AccountResponse> updateAccount(dynamic body, String id) async {
    BaseResult response = await put(
      Endpoint.updateBank.replaceAll("{id}", id),
      body: body,
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return AccountResponse.fromJson(response.data);
      default:
        return AccountResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<BaseResponse> deleteAccount(dynamic body, String id) async {
    BaseResult response = await delete(
      Endpoint.deleteBank.replaceAll("{id}", id),
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return BaseResponse.fromJson(response.data);
      default:
        return BaseResponse(
          message: response.errorMessage,
        );
    }
  }

  Future<BalanceResponse> getBalanceWithdraw() async {
    BaseResult response = await get(Endpoint.withdrawBalance);
    switch (response.status) {
      case ResponseStatus.Success:
        return BalanceResponse.fromJson(response.data);
      default:
        return BalanceResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<WithdrawListResponse> getListWithdraw() async {
    BaseResult response = await get(Endpoint.withdraw);
    switch (response.status) {
      case ResponseStatus.Success:
        return WithdrawListResponse.fromJson(response.data);
      default:
        return WithdrawListResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<WithdrawResponse> postWithdraw(dynamic body) async {
    BaseResult response = await post(Endpoint.withdraw, body: body);
    switch (response.status) {
      case ResponseStatus.Success:
        return WithdrawResponse.fromJson(response.data);
      default:
        return WithdrawResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }
}
