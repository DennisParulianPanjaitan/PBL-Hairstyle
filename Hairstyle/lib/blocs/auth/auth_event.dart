part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final RegisterFormModel data;
  const AuthRegister(this.data);

  @override
  List<Object> get props => [data];
}
