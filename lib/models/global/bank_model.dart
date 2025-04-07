class BankListResponse {
  List<BankModel>? data;
  String? message;
  bool? error;

  BankListResponse({
    this.data,
    this.message,
    this.error,
  });

  BankListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BankModel>[];
      json['data'].forEach((v) {
        data?.add(new BankModel.fromJson(v));
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

class BankResponse {
  BankModel? data;
  String? message;
  bool? error;

  BankResponse({
    this.data,
    this.message,
    this.error,
  });

  BankResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new BankModel.fromJson(json['data']) : null;
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

class BankModel {
  String? code;
  String? name;

  BankModel({
    this.code,
    this.name,
  });

  BankModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
