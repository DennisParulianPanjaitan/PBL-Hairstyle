import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(LoginInitial()) {
    // Handle LoginButtonPressed event
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final response = await authService.login(event.username, event.password);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', response['token']);
        emit(LoginSuccess(token: response['token']));
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
