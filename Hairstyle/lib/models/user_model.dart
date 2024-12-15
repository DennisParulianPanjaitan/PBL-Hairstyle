// class UserModel {
//   final int? id;
//   final String? username;
//   final String? email;
//   final String? password;
//   final String? token;

//   UserModel({
//     this.id,
//     this.username,
//     this.email,
//     this.password,
//     this.token,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json['id'],
//         username: json['username'],
//         email: json['email'],
//         password: json['password'],
//         token: json['token'],
//       );

//   UserModel copyWith({
//     String? username,
//     String? email,
//     String? password,
//   }) =>
//       UserModel(
//         id: id,
//         username: username ?? this.username,
//         email: email ?? this.email,
//         password: password ?? this.password,
//         token: token,
//       );
// }
// class UserModel {
//   // final String token;
//   final String username;
//   final String email;

//   UserModel({
//     // required this.token,
//     required this.username,
//     required this.email,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       // token: json['token'] ?? '', // default empty string if null
//       username: json['username'] ?? '',
//       email: json['email'] ?? '', // default empty string if null
//     );
//   }
// }

class UserModel {
  final int id;
  final String email;
  final String username;
  final int id;
  final String picturePath;

  UserModel(
      {/* required this.email, */ required this.email,
      required this.username,
      required this.id,
      required this.picturePath});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        // id: json['id'],
        email: json['email'],
        username: json['username'],
        id: json['id'],
        picturePath: json['profile_picture_url']);
  }
}

class RegisterModel {
  final String username;
  final String email;
  final String password;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
