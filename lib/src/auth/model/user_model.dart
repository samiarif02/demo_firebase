class UserModel {
  UserModel({
      this.id, 
      this.profileImg, 
      this.fullName,
      this.email,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    profileImg = json['profileImg'];
    fullName = json['fullName'];
    email = json['email'];
  }
  String? id;
  String? profileImg;
  String? fullName;
  String? email;
UserModel copyWith({  String? id,
  String? profileImg,
  String? fullName,
  String? email,
}) => UserModel(  id: id ?? this.id,
  profileImg: profileImg ?? this.profileImg,
  fullName: fullName ?? this.fullName,
  email: email ?? this.email,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['profileImg'] = profileImg;
    map['fullName'] = fullName;
    map['email'] = email;
    return map;
  }



}