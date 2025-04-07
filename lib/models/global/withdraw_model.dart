class WithdrawListResponse {
  List<WithdrawModel>? data;
  String? message;
  bool? error;

  WithdrawListResponse({
    this.data,
    this.message,
    this.error,
  });

  WithdrawListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <WithdrawModel>[];
      json['data'].forEach((v) {
        data?.add(new WithdrawModel.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toList();
    }
    data['messages'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class WithdrawResponse {
  WithdrawModel? data;
  String? message;
  bool? error;

  WithdrawResponse({
    this.data,
    this.message,
    this.error,
  });

  WithdrawResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new WithdrawModel.fromJson(json['data']) : null;
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

class WithdrawModel {
  String? id;
  int? amount;
  String? bank_name;
  String? bank_account_name;
  String? bank_account_number;
  String? status;
  String? initiated_at;
  String? processed_at;

  WithdrawModel({
    this.id,
    this.amount,
    this.bank_name,
    this.bank_account_name,
    this.bank_account_number,
    this.status,
    this.initiated_at,
    this.processed_at,
  });

  WithdrawModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    bank_name = json['bank_name'];
    bank_account_name = json['bank_account_name'];
    bank_account_number = json['bank_account_number'];
    status = json['status'];
    initiated_at = json['initiated_at'];
    processed_at = json['processed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['bank_name'] = this.bank_name;
    data['bank_account_name'] = this.bank_account_name;
    data['bank_account_number'] = this.bank_account_number;
    data['status'] = this.status;
    data['initiated_at'] = this.initiated_at;
    data['processed_at'] = this.processed_at;
    return data;
  }
}
