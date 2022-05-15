class User {
  String username;
  String fullName;
  String email;
  String? phone;

  User({
    required this.username,
    required this.fullName,
    required this.email,
    this.phone,
  });
}
