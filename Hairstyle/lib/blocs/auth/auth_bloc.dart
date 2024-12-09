// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../services/registest_service.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final RegistAuth registAuth;

//   AuthBloc({required this.registAuth}) : super(AuthInitial()) {
//     on<AuthRegister>((event, emit) async {
//       emit(AuthLoading());

//       try {
//         // Panggil metode register dari RegistAuth dengan data yang diterima dari event
//         await registAuth.register(
//           username: event.username,
//           email: event.email,
//           password: event.password,
//         );
//         emit(AuthSuccess('Registration Successful'));
//       } catch (error) {
//         emit(AuthFailed(error.toString()));
//       }
//     });

//     // Anda bisa menambahkan lebih banyak event jika perlu
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/register.dart';
import '../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authService.register(
          RegisterRequest(
            username: event.username,
            email: event.email,
            password: event.password,
          ),
        );
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
