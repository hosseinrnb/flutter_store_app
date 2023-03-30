import 'package:bloc/bloc.dart';
import 'package:flutter_store_app/bloc/authentication/auth_event.dart';
import 'package:flutter_store_app/bloc/authentication/auth_state.dart';
import 'package:flutter_store_app/data/repository/authentication_repository.dart';
import 'package:flutter_store_app/di/di.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState> {

  final IAuthRepository _repository = locator.get();

  AuthBloc():super(AuthInitiateState()){
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.login(event.username, event.password);
      emit(AuthResponseState(response));
    },);
  }
}