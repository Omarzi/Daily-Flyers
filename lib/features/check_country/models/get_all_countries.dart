// class GetAllCountriesModel {
//   int? id;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   String? arName;
//   String? enName;
//   String? image;
//   bool? enabled;
//
//   GetAllCountriesModel(
//       {this.id,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.arName,
//         this.enName,
//         this.image,
//         this.enabled});
//
//   GetAllCountriesModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     arName = json['ar_name'];
//     enName = json['en_name'];
//     image = json['image'];
//     enabled = json['enabled'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     data['ar_name'] = this.arName;
//     data['en_name'] = this.enName;
//     data['image'] = this.image;
//     data['enabled'] = this.enabled;
//     return data;
//   }
// }
class GetAllCountriesModel {
  int id;
  String arName;
  String enName;
  String image;
  bool enabled;
  DateTime createdAt;
  DateTime updatedAt;

  GetAllCountriesModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.image,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetAllCountriesModel.fromJson(Map<String, dynamic> json) {
    return GetAllCountriesModel(
      id: json['id'],
      arName: json['ar_name'],
      enName: json['en_name'],
      image: json['image'],
      enabled: json['enabled'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  static List<GetAllCountriesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GetAllCountriesModel.fromJson(json)).toList();
  }
}
