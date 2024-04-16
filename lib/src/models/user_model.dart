class User {
  final int id;
  final String name;
  final String email;
  final String password;
  // final String profilePicture;
  // final String telephoneNumber;

  User({required this.id, required this.name, required this.email, required this.password});

  factory User.fromSqfliteDatabase(Map<String, dynamic> map) => User(
    id: map['id']?.toInt() ?? 0,
    name: map['name'] ?? '',
    email: map['email'] ?? '',
    password: map['password'] ?? '',
    );
}