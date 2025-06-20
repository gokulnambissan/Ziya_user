class UserModel {
  final String name;
  final String? email;

  UserModel({required this.name, this.email});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'],
    );
  }
}