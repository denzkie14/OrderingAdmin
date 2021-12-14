class User {
  int? user_id;
  String? code;
  String? username;
  String? password;

  String? fname;
  String? mname;
  String? lname;
  String? ext_name;
  DateTime? birthday;
  String? gender;
  String? user_type;
  String? token;
  bool? isActive;

  // int? id;
  // int? categoryId;
  // int? unitId;
  // String? unit;
  // String? category;
  // String? code;
  // String? title;
  // String? description;
  // List<String>? images;
  // num? price;
  // int? stock;
  // DateTime? expirationDate;
  // DateTime? dateAdded;
  // int? addedBy;

  User(
      {this.user_id,
      this.code,
      this.username,
      this.password,
      this.fname,
      this.mname,
      this.lname,
      this.ext_name,
      this.birthday,
      this.gender,
      this.user_type,
      this.token,
      this.isActive});

  User.fromJson(Map<String, dynamic> json) {
    this.user_id = json['user_id'];
    this.code = json['code'];
    this.username = json['username'];
    this.password = json['password'];
    this.fname = json['fname'];
    this.mname = json['mname'];
    this.lname = json['lname'];
    this.ext_name = json['ext_name'];
    this.birthday = DateTime.parse(json['birthday']);
    this.gender = json['gender'];
    this.user_type = json['user_type'];
    this.token = json['token'];
    this.isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'code': code,
        'username': username,
        'password': password,
        'fname': fname,
        'mname': mname,
        'lname': lname,
        'ext_name': ext_name,
        'birthday': birthday.toString(),
        'gender': gender,
        'user_type': user_type,
        'token': token,
        'isActive': isActive,
      };
}

class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    this.username = json['username'];
    this.password = json['password'];
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
