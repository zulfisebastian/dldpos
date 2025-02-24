class ProfileResponse {
  ProfileModel? data;
  String? message;
  bool? error;

  ProfileResponse({
    this.data,
    this.message,
    this.error,
  });

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new ProfileModel.fromJson(json['data']) : null;
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

class ProfileModel {
  String? id;
  String? full_name;
  String? username;
  String? email;
  String? phone;
  String? status;
  String? role;

  ProfileModel({
    this.id,
    this.full_name,
    this.username,
    this.email,
    this.phone,
    this.status,
    this.role,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    full_name = json['full_name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.full_name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['role'] = this.role;
    return data;
  }
}
