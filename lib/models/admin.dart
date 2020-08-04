class Admin {
  const Admin({
    this.userName,
    this.password,
  });

  final String userName;
  final String password;

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      userName: json["userName"] as String,
      password: json["password"] as String,
    );
  }
}