class LoginResponse {
  LoginModel? data;
  String? message;
  int? status;

  LoginResponse({
    this.data,
    this.message,
    this.status,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LoginModel.fromJson(json['data']) : null;
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

class LoginModel {
  String? id;
  String? name;
  String? token;

  LoginModel({
    this.id,
    this.name,
    this.token,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['token'] = this.token;
    return data;
  }
}
