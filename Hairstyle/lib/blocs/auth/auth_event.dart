abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  RegisterEvent({
    required this.username,
    required this.email,
    required this.password,
  });
}
