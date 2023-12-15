/// Model class to hold user response data
class UserModel {
  final int id;
  final String name;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  ///constructor to parse json data and return UserModel Model Instance
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['Id'],
      name: json['Name'],
      email: json['Email'],
    );
  }
}
