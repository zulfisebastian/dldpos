import '../../constants/endpoints.dart';
import '../../models/base/base_result.dart';
import '../../models/transaction/transaction_model.dart';
import '../base/base_repo.dart';

class TransactionRepo extends BaseRepo {
  Future<TransactionListResponse> getTransactions(dynamic body) async {
    BaseResult response = await get(
      Endpoint.transaction,
      queryParameters: body,
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return TransactionListResponse.fromJson(response.data);
      default:
        return TransactionListResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<TransactionResponse> getTransactionById(String id) async {
    BaseResult response = await get(
      Endpoint.transactionById.replaceFirst('{id}', id),
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return TransactionResponse.fromJson(response.data);
      default:
        return TransactionResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }

  Future<TransactionResponse> postTransaction(dynamic body) async {
    BaseResult response = await post(
      Endpoint.transaction,
      body: body,
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return TransactionResponse.fromJson(response.data);
      default:
        return TransactionResponse(
          error: true,
          message: response.errorMessage,
        );
    }
  }
}
