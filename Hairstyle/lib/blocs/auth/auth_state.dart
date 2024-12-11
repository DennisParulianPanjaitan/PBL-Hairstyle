// import '../../models/user_model.dart';

// abstract class AuthState {
//   const AuthState();

//   List<Object> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthSuccess extends AuthState {
//   final UserModel user;

//   AuthSuccess(this.user);
//   @override
//   List<Object> get props => [user];
// }

// class AuthFailure extends AuthState {
//   final String message;

//   AuthFailure(this.message);

//   @override
//   List<Object> get props => [message];
// }

import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;

  AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthRegistered extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
