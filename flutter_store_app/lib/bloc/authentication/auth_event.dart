abstract class AuthEvent{}

class AuthLoginRequest extends AuthEvent{
  AuthLoginRequest(this.username, this.password);

  String username;
  String password;
}