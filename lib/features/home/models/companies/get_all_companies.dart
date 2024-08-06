// class GetAllCompaniesModel {
//   List<CompanyData>? data;
//   Meta? meta;
//
//   GetAllCompaniesModel({this.data, this.meta});
//
//   GetAllCompaniesModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <CompanyData>[];
//       json['data'].forEach((v) {
//         data!.add(new CompanyData.fromJson(v));
//       });
//     }
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     return data;
//   }
// }
//
// class CompanyData {
//   int? id;
//   String? enName;
//   String? arName;
//   String? colorLogo;
//   String? grayLogo;
//   int? views;
//   int? nonExpiredOffers;
//   List<Categories>? categories;
//   List<Countries>? countries;
//
//   CompanyData(
//       {this.id,
//         this.enName,
//         this.arName,
//         this.colorLogo,
//         this.grayLogo,
//         this.views,
//         this.nonExpiredOffers,
//         this.categories,
//         this.countries});
//
//   CompanyData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     enName = json['en_name'];
//     arName = json['ar_name'];
//     colorLogo = json['color_logo'];
//     grayLogo = json['gray_logo'];
//     views = json['views'];
//     nonExpiredOffers = json['nonExpiredOffers'];
//     if (json['categories'] != null) {
//       categories = <Categories>[];
//       json['categories'].forEach((v) {
//         categories!.add(new Categories.fromJson(v));
//       });
//     }
//     if (json['countries'] != null) {
//       countries = <Countries>[];
//       json['countries'].forEach((v) {
//         countries!.add(new Countries.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['en_name'] = this.enName;
//     data['ar_name'] = this.arName;
//     data['color_logo'] = this.colorLogo;
//     data['gray_logo'] = this.grayLogo;
//     data['views'] = this.views;
//     data['nonExpiredOffers'] = this.nonExpiredOffers;
//     if (this.categories != null) {
//       data['categories'] = this.categories!.map((v) => v.toJson()).toList();
//     }
//     if (this.countries != null) {
//       data['countries'] = this.countries!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Categories {
//   int? id;
//   String? enName;
//   String? arName;
//
//   Categories({this.id, this.enName, this.arName});
//
//   Categories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     enName = json['en_name'];
//     arName = json['ar_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['en_name'] = this.enName;
//     data['ar_name'] = this.arName;
//     return data;
//   }
// }
//
// class Countries {
//   int? id;
//   String? enName;
//   String? arName;
//   String? image;
//   bool? enabled;
//
//   Countries({this.id, this.enName, this.arName, this.image, this.enabled});
//
//   Countries.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     enName = json['en_name'];
//     arName = json['ar_name'];
//     image = json['image'];
//     enabled = json['enabled'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['en_name'] = this.enName;
//     data['ar_name'] = this.arName;
//     data['image'] = this.image;
//     data['enabled'] = this.enabled;
//     return data;
//   }
// }
//
// class Meta {
//   int? itemsPerPage;
//   int? totalItems;
//   String? currentPage;
//   int? totalPages;
//   String? search;
//   List<String>? searchBy;
//
//   Meta(
//       {this.itemsPerPage,
//         this.totalItems,
//         this.currentPage,
//         this.totalPages,
//         this.search,
//         this.searchBy});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     itemsPerPage = json['itemsPerPage'];
//     totalItems = json['totalItems'];
//     currentPage = json['currentPage'];
//     totalPages = json['totalPages'];
//     search = json['search'];
//     searchBy = json['searchBy'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['itemsPerPage'] = this.itemsPerPage;
//     data['totalItems'] = this.totalItems;
//     data['currentPage'] = this.currentPage;
//     data['totalPages'] = this.totalPages;
//     data['search'] = this.search;
//     data['searchBy'] = this.searchBy;
//     return data;
//   }
// }
//

class GetAllCompaniesModel {
  List<CompanyData>? data;
  Meta? meta;

  GetAllCompaniesModel({this.data, this.meta});

  GetAllCompaniesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(new CompanyData.fromJson(v));
      });
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

class CompanyData {
  int? id;
  String? enName;
  String? arName;
  String? colorLogo;
  String? grayLogo;
  int? views;
  int? nonExpiredOffers;
  List<Categories>? categories;
  List<Countries>? countries;
  int? favorites;

  CompanyData(
      {this.id,
        this.enName,
        this.arName,
        this.colorLogo,
        this.grayLogo,
        this.views,
        this.nonExpiredOffers,
        this.categories,
        this.countries,
        this.favorites});

  CompanyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    colorLogo = json['color_logo'];
    grayLogo = json['gray_logo'];
    views = json['views'];
    nonExpiredOffers = json['nonExpiredOffers'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    favorites = json['favorites'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['en_name'] = this.enName;
    data['ar_name'] = this.arName;
    data['color_logo'] = this.colorLogo;
    data['gray_logo'] = this.grayLogo;
    data['views'] = this.views;
    data['nonExpiredOffers'] = this.nonExpiredOffers;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    data['favorites'] = this.favorites;
    return data;
  }
}

class Categories {
  int? id;
  String? enName;
  String? arName;

  Categories({this.id, this.enName, this.arName});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['en_name'] = this.enName;
    data['ar_name'] = this.arName;
    return data;
  }
}

class Countries {
  int? id;
  String? enName;
  String? arName;
  String? image;
  bool? enabled;

  Countries({this.id, this.enName, this.arName, this.image, this.enabled});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    image = json['image'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['en_name'] = this.enName;
    data['ar_name'] = this.arName;
    data['image'] = this.image;
    data['enabled'] = this.enabled;
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


// class GetAllCompaniesModel {
//   List<CompanyData>? data;
//
//   GetAllCompaniesModel({this.data});
//
//   GetAllCompaniesModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <CompanyData>[];
//       json['data'].forEach((v) {
//         data!.add(new CompanyData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class CompanyData {
//   int? id;
//   String? enName;
//   String? arName;
//   String? colorLogo;
//   String? grayLogo;
//   int? views;
//   int? nonExpiredOffers;
//   List<Categories>? categories;
//   List<Countries>? countries;
//
//   CompanyData(
//       {this.id,
//         this.enName,
//         this.arName,
//         this.colorLogo,
//         this.grayLogo,
//         this.views,
//         this.nonExpiredOffers,
//         this.categories,
//         this.countries});
//
//   CompanyData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     enName = json['en_name'];
//     arName = json['ar_name'];
//     colorLogo = json['color_logo'];
//     grayLogo = json['gray_logo'];
//     views = json['views'];
//     nonExpiredOffers = json['nonExpiredOffers'];
//     if (json['categories'] != null) {
//       categories = <Categories>[];
//       json['categories'].forEach((v) {
//         categories!.add(new Categories.fromJson(v));
//       });
//     }
//     if (json['countries'] != null) {
//       countries = <Countries>[];
//       json['countries'].forEach((v) {
//         countries!.add(new Countries.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['en_name'] = this.enName;
//     data['ar_name'] = this.arName;
//     data['color_logo'] = this.colorLogo;
//     data['gray_logo'] = this.grayLogo;
//     data['views'] = this.views;
//     data['nonExpiredOffers'] = this.nonExpiredOffers;
//     if (this.categories != null) {
//       data['categories'] = this.categories!.map((v) => v.toJson()).toList();
//     }
//     if (this.countries != null) {
//       data['countries'] = this.countries!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Categories {
//   int? id;
//   String? enName;
//   String? arName;
//
//   Categories({this.id, this.enName, this.arName});
//
//   Categories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     enName = json['en_name'];
//     arName = json['ar_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['en_name'] = this.enName;
//     data['ar_name'] = this.arName;
//     return data;
//   }
// }
//
// class Countries {
//   int? id;
//   String? enName;
//   String? arName;
//   String? image;
//   bool? enabled;
//
//   Countries({this.id, this.enName, this.arName, this.image, this.enabled});
//
//   Countries.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     enName = json['en_name'];
//     arName = json['ar_name'];
//     image = json['image'];
//     enabled = json['enabled'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['en_name'] = this.enName;
//     data['ar_name'] = this.arName;
//     data['image'] = this.image;
//     data['enabled'] = this.enabled;
//     return data;
//   }
// }
