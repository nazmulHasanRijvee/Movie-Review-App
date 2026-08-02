class UserModel {

  final int accountId;
  final String name;
  final String userName;
  final String image;

  const UserModel({
    required this.accountId,
    required this.name,
    required this.userName,
    required this.image
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
      accountId: json['id'],
      name: json['name'],
      userName: json['username'],
      image: json['avatar']['tmdb']['avatar_path']
    );

  }

  Map<String, dynamic> toJson() {
    return {
      "id" : accountId,
      "name" : name,
      "username" : userName,
      "avatar" : {
        "tmdb" : {
          "avatar_path" : image
        }
      }
    };
  }

}