class AccountListResponse {
  List<AccountModel>? data;
  String? message;
  bool? error;

  AccountListResponse({
    this.data,
    this.message,
    this.error,
  });

  AccountListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AccountModel>[];
      json['data'].forEach((v) {
        data?.add(new AccountModel.fromJson(v));
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

class AccountResponse {
  AccountModel? data;
  String? message;
  bool? error;

  AccountResponse({
    this.data,
    this.message,
    this.error,
  });

  AccountResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new AccountModel.fromJson(json['data']) : null;
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

class AccountModel {
  String? id;
  String? name;
  String? bank_code;
  String? account_number;
  String? account_name;
  String? status;

  AccountModel({
    this.id,
    this.name,
    this.bank_code,
    this.account_number,
    this.account_name,
    this.status,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bank_code = json['bank_code'];
    account_number = json['account_number'];
    account_name = json['account_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bank_code'] = this.bank_code;
    data['account_number'] = this.account_number;
    data['account_name'] = this.account_name;
    data['status'] = this.status;
    return data;
  }
}
