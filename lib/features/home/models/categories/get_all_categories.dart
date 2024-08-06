class GetAllCategoriesModel {
  List<CategoryData>? data;

  GetAllCategoriesModel({this.data});

  GetAllCategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  int? id;
  String? enName;
  String? arName;

  CategoryData({this.id, this.enName, this.arName});

  CategoryData.fromJson(Map<String, dynamic> json) {
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
