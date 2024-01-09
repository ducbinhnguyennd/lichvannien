class UserData {
  final String email;
  String uid;
  final String name;
  final String phone;
  //final DateTime birthday;
  final String birthday;
  final String gt;
  UserData({
    required this.email,
    this.uid: '',
    required this.name,
    required this.phone,
    required this.birthday,
    required this.gt,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
        "email": email,
        "birthday": birthday,
        "gt": gt,
      };

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json['uid'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        birthday: json['birthday'],
        gt: json['gt'],
      );
}
