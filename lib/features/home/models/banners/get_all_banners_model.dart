class GetAllBannersModel {
  List<Data>? data;
  // Meta? meta;

  GetAllBannersModel({
    this.data,
    // this.meta,
  });

  GetAllBannersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
    }
    // meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    // if (this.meta != null) {
    //   data['meta'] = this.meta!.toJson();
    // }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  int? countryId;

  Data({this.id, this.image, this.countryId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['country_id'] = this.countryId;
    return data;
  }
}

// class Meta {
//   int? itemsPerPage;
//   int? totalItems;
//   int? currentPage;
//   int? totalPages;
//   List<List>? sortBy;
//
//   Meta({this.itemsPerPage, this.totalItems, this.currentPage, this.totalPages, this.sortBy});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     itemsPerPage = json['itemsPerPage'];
//     totalItems = json['totalItems'];
//     currentPage = json['currentPage'];
//     totalPages = json['totalPages'];
//     if (json['sortBy'] != null) {
//       sortBy = <List>[];
//       json['sortBy'].forEach((v) { sortBy!.add(new List.fromJson(v)); });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['itemsPerPage'] = this.itemsPerPage;
//     data['totalItems'] = this.totalItems;
//     data['currentPage'] = this.currentPage;
//     data['totalPages'] = this.totalPages;
//     if (this.sortBy != null) {
//       data['sortBy'] = this.sortBy!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class SortBy {
//
//
//   SortBy({});
//
// SortBy.fromJson(Map<String, dynamic> json) {
// }
//
// Map<String, dynamic> toJson() {
// final Map<String, dynamic> data = new Map<String, dynamic>();
// return data;
// }
// }
