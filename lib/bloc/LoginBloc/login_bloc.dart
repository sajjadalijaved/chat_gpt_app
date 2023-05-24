import 'package:bloc/bloc.dart';
import 'package:chat_gpt/auhthentication/authenticationPage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSuccessfulEvent>((event, emit)async {
        emit.call(LoginLoadingState());
      try {
       User? user =  await loginuser(event.email,event.password);
         emit.call(LoginLoadedState(user));
        
      } on FirebaseAuthException catch (e)
      {
       emit.call(LoginErrorState(e.toString()));
      } catch (e) {
        emit.call(LoginErrorState(e.toString()));
      }
    });
  }
}
