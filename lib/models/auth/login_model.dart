class LoginResponse {
  LoginModel? data;
  String? message;
  bool? error;

  LoginResponse({
    this.data,
    this.message,
    this.error,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LoginModel.fromJson(json['data']) : null;
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

class LoginModel {
  String? access_token;

  LoginModel({
    this.access_token,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.access_token;
    return data;
  }
}
