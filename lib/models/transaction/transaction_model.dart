import 'package:dld/models/transaction/invoice_model.dart';

class TransactionListResponse {
  List<TransactionModel>? data;
  String? message;
  bool? error;

  TransactionListResponse({
    this.data,
    this.message,
    this.error,
  });

  TransactionListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TransactionModel>[];
      json['data'].forEach((v) {
        data?.add(new TransactionModel.fromJson(v));
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

class TransactionResponse {
  TransactionModel? data;
  String? message;
  bool? error;

  TransactionResponse({
    this.data,
    this.message,
    this.error,
  });

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new TransactionModel.fromJson(json['data'])
        : null;
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

class TransactionModel {
  String? number;
  String? type;
  String? created_at;
  int? total;
  String? payment_method;
  String? payment_status;
  InvoiceModel? invoice;

  TransactionModel({
    this.number,
    this.type,
    this.created_at,
    this.total,
    this.payment_method,
    this.payment_status,
    this.invoice,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    type = json['type'];
    created_at = json['created_at'];
    total = json['total'];
    payment_method = json['payment_method'];
    payment_status = json['payment_status'];
    invoice = json['invoice'] != null
        ? new InvoiceModel.fromJson(json['invoice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['type'] = this.type;
    data['total'] = this.total;
    data['created_at'] = this.created_at;
    data['payment_method'] = this.payment_method;
    data['payment_status'] = this.payment_status;
    if (this.invoice != null) {
      data['invoice'] = this.invoice?.toJson();
    }
    return data;
  }
}
