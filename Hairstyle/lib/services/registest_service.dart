import 'dart:convert';

import 'package:uts_linkaja/models/register.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class RegistTest {
  Future<UserModel> register(RegisterFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('https://tomascan.nurulmustofa.my.id/api/register'),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        user = user.copyWith(password: data.password);

        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
