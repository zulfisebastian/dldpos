class InvoiceListResponse {
  List<InvoiceModel>? data;
  String? message;
  bool? error;

  InvoiceListResponse({
    this.data,
    this.message,
    this.error,
  });

  InvoiceListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InvoiceModel>[];
      json['data'].forEach((v) {
        data?.add(new InvoiceModel.fromJson(v));
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

class InvoiceResponse {
  InvoiceModel? data;
  String? message;
  bool? error;

  InvoiceResponse({
    this.data,
    this.message,
    this.error,
  });

  InvoiceResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new InvoiceModel.fromJson(json['data']) : null;
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

class InvoiceModel {
  String? number;
  String? partner_ref_no;
  String? ref_no;
  int? nominal;
  String? local_qr_url;
  String? status;
  String? expired_in;

  InvoiceModel({
    this.number,
    this.partner_ref_no,
    this.ref_no,
    this.nominal,
    this.local_qr_url,
    this.status,
    this.expired_in,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    partner_ref_no = json['partner_ref_no'];
    ref_no = json['ref_no'];
    nominal = json['nominal'];
    local_qr_url = json['local_qr_url'];
    status = json['status'];
    expired_in = json['expired_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['partner_ref_no'] = this.partner_ref_no;
    data['ref_no'] = this.ref_no;
    data['nominal'] = this.nominal;
    data['local_qr_url'] = this.local_qr_url;
    data['status'] = this.status;
    data['expired_in'] = this.expired_in;
    return data;
  }
}
