import 'package:dld/models/base/meta_model.dart';

class BannerListResponse {
  BannerResultResponse? data;
  String? message;
  int? status;

  BannerListResponse({
    this.data,
    this.message,
    this.status,
  });

  BannerListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new BannerResultResponse.fromJson(json['data']);
    }
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

class BannerResultResponse {
  List<BannerModel>? results;
  MetaModel? meta;

  BannerResultResponse({
    this.results,
    this.meta,
  });

  BannerResultResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <BannerModel>[];
      json['results'].forEach((v) {
        results?.add(new BannerModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new MetaModel.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results?.toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta?.toJson();
    }
    return data;
  }
}

class BannerResponse {
  BannerModel? data;
  String? message;
  int? status;

  BannerResponse({
    this.data,
    this.message,
    this.status,
  });

  BannerResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new BannerModel.fromJson(json['data']) : null;
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

class BannerModel {
  String? id;
  String? image;

  BannerModel({
    this.id,
    this.image,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
