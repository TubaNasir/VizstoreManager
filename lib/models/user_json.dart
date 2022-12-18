class UserJson {
  String? id;
  String? email;
  String firstName;
  String lastName;
  String contact;
  String photoUrl;

  UserJson({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.contact,
    this.photoUrl = 'https://img.icons8.com/bubbles/50/000000/user.png',
  });

  UserJson.empty()
      : email = '',
        firstName = 'h',
        lastName = '',
        contact = '',
        photoUrl = '';

  UserJson copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? contact,
    String? email,
  }) =>
      UserJson(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        contact: contact ?? this.contact,
        email: email ?? this.email,
      );

  static UserJson fromJson(Map<String, dynamic> json, String id) {
    return UserJson(
      id: id as String? ?? '',
      email: json["email"] as String? ?? '',
      firstName: json["firstName"] as String? ?? '',
      lastName: json["lastName"] as String? ?? '',
      contact: json["contact"] as String? ?? '',
      photoUrl: json["photoUrl"] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        //"id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "contact": contact,
        "photoUrl": photoUrl,
      };
}
