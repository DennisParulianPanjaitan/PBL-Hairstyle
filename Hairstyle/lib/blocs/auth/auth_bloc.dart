// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../../services/registest_service.dart';
// // import 'auth_event.dart';
// // import 'auth_state.dart';

// // class AuthBloc extends Bloc<AuthEvent, AuthState> {
// //   final RegistAuth registAuth;

// //   AuthBloc({required this.registAuth}) : super(AuthInitial()) {
// //     on<AuthRegister>((event, emit) async {
// //       emit(AuthLoading());

// //       try {
// //         // Panggil metode register dari RegistAuth dengan data yang diterima dari event
// //         await registAuth.register(
// //           username: event.username,
// //           email: event.email,
// //           password: event.password,
// //         );
// //         emit(AuthSuccess('Registration Successful'));
// //       } catch (error) {
// //         emit(AuthFailed(error.toString()));
// //       }
// //     });

// //     // Anda bisa menambahkan lebih banyak event jika perlu
// //   }
// // }
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
// import 'package:uts_linkaja/blocs/auth/auth_state.dart';
// import '../../models/auth.dart';
// import '../../services/auth_service.dart';
// part 'auth_event.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService authService;

//   AuthBloc(this.authService) : super(AuthInitial()) {
//     // Event handler untuk RegisterEvent
//     on<RegisterEvent>((event, emit) async {
//       try {
//         emit(AuthLoading());
//         final user = await authService.register(RegisterRequest(
//           username: event.username,
//           email: event.email,
//           password: event.password,
//         ));
//         emit(AuthSuccess(user));
//       } catch (e) {
//         emit(AuthFailure('Registration failed. Please try again.'));
//       }
//     });

//     // Event handler untuk LoginEvent
//     on<LoginEvent>((event, emit) async {
//       try {
//         emit(AuthLoading());
//         final user = await authService.login(LoginRequest(
//           email: event.email,
//           password: event.password,
//         ));
//         emit(AuthSuccess(user));
//       } catch (e) {
//         emit(AuthFailure(e.toString()));
//       }
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authService.login(event.email, event.password);
        if (user != null) {
          emit(AuthSuccess(user: user));
        }
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final isRegistered = await authService.register({
          'username': event.username,
          'email': event.email,
          'password': event.password,
        });
        if (isRegistered) {
          emit(AuthRegistered());
        }
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });
  }
}
