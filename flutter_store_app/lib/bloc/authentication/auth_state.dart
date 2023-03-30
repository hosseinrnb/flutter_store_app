import 'package:dartz/dartz.dart';

abstract class AuthState{}

class AuthInitiateState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthResponseState extends AuthState{
  AuthResponseState(this.response);

  Either<String,String> response;
}