class ProfileDataModel {
  int? id;
  String? name;
  String? email;
  List<FavCompanies>? favCompanies;
  Countries? country;
  String? createdAt;

  ProfileDataModel(
      {this.id,
        this.name,
        this.email,
        this.favCompanies,
        this.country,
        this.createdAt});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    if (json['fav_companies'] != null) {
      favCompanies = <FavCompanies>[];
      json['fav_companies'].forEach((v) {
        favCompanies!.add(new FavCompanies.fromJson(v));
      });
    }
    country = json['country'] != null
        ? new Countries.fromJson(json['country'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.favCompanies != null) {
      data['fav_companies'] =
          this.favCompanies!.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class FavCompanies {
  int? id;
  String? enName;
  String? arName;
  String? colorLogo;
  String? grayLogo;
  int? views;
  List<Categories>? categories;
  List<Countries>? countries;
  int? favorites;

  FavCompanies(
      {this.id,
        this.enName,
        this.arName,
        this.colorLogo,
        this.grayLogo,
        this.views,
        this.favorites,
        this.categories,
        this.countries});

  FavCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    colorLogo = json['color_logo'];
    grayLogo = json['gray_logo'];
    views = json['views'];
    favorites = json['favorites'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['en_name'] = this.enName;
    data['ar_name'] = this.arName;
    data['color_logo'] = this.colorLogo;
    data['gray_logo'] = this.grayLogo;
    data['views'] = this.views;
    data['favorites'] = this.favorites;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
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
