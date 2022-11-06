class User {
  String name;
  String birthday;
  User({required this.name, required this.birthday});

  Map<String, dynamic> toJson() => {'name': name, 'birthday': birthday};
  static User fromJson(Map<String, dynamic> json) =>
      User(name: json['name'], birthday: json['birthday']);
}
