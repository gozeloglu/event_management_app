class Participant {
  const Participant({
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.password,
    this.age,
    this.identityNumber,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String password;
  final int age;
  final String identityNumber;

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      firstName: json["firstName"] as String,
      lastName: json["lastName"] as String,
      email: json["email"] as String,
      userName: json["userName"] as String,
      password: json["password"] as String,
      age: json["age"] as int,
      identityNumber: json["identityNumber"] as String,
    );
  }
}