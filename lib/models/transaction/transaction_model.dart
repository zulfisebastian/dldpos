import '../base/meta_model.dart';

class TransactionListResponse {
  TransactionResultResponse? data;
  String? message;
  int? status;

  TransactionListResponse({
    this.data,
    this.message,
    this.status,
  });

  TransactionListResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new TransactionResultResponse.fromJson(json['data'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['messages'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class TransactionResultResponse {
  List<TransactionModel>? results;
  MetaModel? meta;

  TransactionResultResponse({
    this.results,
    this.meta,
  });

  TransactionResultResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <TransactionModel>[];
      json['results'].forEach((v) {
        results?.add(new TransactionModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new MetaModel.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['data'] = this.results?.toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta?.toJson();
    }
    return data;
  }
}

class TransactionResponse {
  TransactionModel? data;
  String? message;
  int? status;

  TransactionResponse({
    this.data,
    this.message,
    this.status,
  });

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new TransactionModel.fromJson(json['data'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['messages'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class TransactionModel {
  String? id;
  String? type;
  String? date;
  int? value;
  String? payment;
  String? payment_at;

  TransactionModel({
    this.id,
    this.type,
    this.date,
    this.value,
    this.payment,
    this.payment_at,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    date = json['date'];
    value = json['value'];
    payment = json['payment'];
    payment_at = json['payment_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['date'] = this.date;
    data['value'] = this.value;
    data['payment'] = this.payment;
    data['payment_at'] = this.payment_at;
    return data;
  }
}
