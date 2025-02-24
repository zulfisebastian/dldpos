class BannerListResponse {
  List<BannerModel>? data;
  String? message;
  bool? error;

  BannerListResponse({
    this.data,
    this.message,
    this.error,
  });

  BannerListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BannerModel>[];
      json['data'].forEach((v) {
        data?.add(new BannerModel.fromJson(v));
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

class BannerResponse {
  BannerModel? data;
  String? message;
  bool? error;

  BannerResponse({
    this.data,
    this.message,
    this.error,
  });

  BannerResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new BannerModel.fromJson(json['data']) : null;
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

class BannerModel {
  String? id;
  String? asset_url;
  String? link;

  BannerModel({
    this.id,
    this.asset_url,
    this.link,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    asset_url = json['asset_url'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['asset_url'] = this.asset_url;
    data['link'] = this.link;
    return data;
  }
}
