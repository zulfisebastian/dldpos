class PaymentListResponse {
  List<String>? data;
  String? message;
  bool? error;

  PaymentListResponse({
    this.data,
    this.message,
    this.error,
  });

  PaymentListResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
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
