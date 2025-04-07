class BalanceResponse {
  BalanceModel? data;
  String? message;
  bool? error;

  BalanceResponse({
    this.data,
    this.message,
    this.error,
  });

  BalanceResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new BalanceModel.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['messages'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class BalanceModel {
  String? currency;
  String? formatted_amount;
  int? amount;

  BalanceModel({
    this.currency,
    this.formatted_amount,
    this.amount,
  });

  BalanceModel.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    formatted_amount = json['formatted_amount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['formatted_amount'] = this.formatted_amount;
    data['amount'] = this.amount;
    return data;
  }
}
