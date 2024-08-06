class UserDataModel {
  String? username;
  String? expiresIn;
  String? accessToken;

  UserDataModel({this.username, this.expiresIn, this.accessToken});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['expires_in'] = this.expiresIn;
    data['access_token'] = this.accessToken;
    return data;
  }
}
