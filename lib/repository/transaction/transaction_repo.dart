import '../../constants/endpoints.dart';
import '../../models/base/base_result.dart';
import '../../models/transaction/transaction_model.dart';
import '../base/base_repo.dart';

class TransactionRepo extends BaseRepo {
  Future<TransactionListResponse> getTransactions(dynamic body) async {
    BaseResult response = await get(
      Endpoint.transactionCustList,
      queryParameters: body,
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return TransactionListResponse.fromJson(response.data);
      default:
        return TransactionListResponse.fromJson(response.data);
    }
  }

  Future<TransactionResponse> getTransactionById(String id) async {
    BaseResult response = await get(
      Endpoint.transactionCustDetail.replaceAll("{id}", id),
    );
    switch (response.status) {
      case ResponseStatus.Success:
        return TransactionResponse.fromJson(response.data);
      default:
        return TransactionResponse.fromJson(response.data);
    }
  }
}
