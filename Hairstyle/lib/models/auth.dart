// class RegisterFormModel {
//   final String? username;
//   final String? email;
//   final String? password;

//   RegisterFormModel({
//     this.username,
//     this.email,
//     this.password,
//   });
//   Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'email': email,
//       'password': password,
//     }..removeWhere((key, value) => value == null);
//   }
// }

class RegisterRequest {
  final String username;
  final String email;
  final String password;

  RegisterRequest({
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

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
