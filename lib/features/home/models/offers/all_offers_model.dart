class AllOffersModel {
  List<OffersData>? data;
  Meta? meta;

  AllOffersModel({this.data, this.meta});

  AllOffersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OffersData>[];
      json['data'].forEach((v) { data!.add(new OffersData.fromJson(v)); });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class OffersData {
  int? id;
  String? arTitle;
  String? enTitle;
  String? arDescription;
  String? enDescription;
  String? image;
  String? startDate;
  String? endDate;
  int? views;

  OffersData({this.id, this.arTitle, this.enTitle, this.arDescription, this.enDescription, this.image, this.startDate, this.endDate, this.views});

  OffersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arTitle = json['ar_title'];
    enTitle = json['en_title'];
    arDescription = json['ar_description'];
    enDescription = json['en_description'];
    image = json['image'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ar_title'] = this.arTitle;
    data['en_title'] = this.enTitle;
    data['ar_description'] = this.arDescription;
    data['en_description'] = this.enDescription;
    data['image'] = this.image;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['views'] = this.views;
    return data;
  }
}

class Meta {
  int? itemsPerPage;
  int? totalItems;
  int? currentPage;
  int? totalPages;

  Meta({this.itemsPerPage, this.totalItems, this.currentPage, this.totalPages});

  Meta.fromJson(Map<String, dynamic> json) {
    itemsPerPage = json['itemsPerPage'];
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemsPerPage'] = this.itemsPerPage;
    data['totalItems'] = this.totalItems;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

