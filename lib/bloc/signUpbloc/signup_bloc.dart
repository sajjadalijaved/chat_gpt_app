import 'package:bloc/bloc.dart';
import 'package:chat_gpt/auhthentication/authenticationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignUpSuccessfulEvent>((event, emit) async{
      emit.call(SignUpLoadingState());
      try {
        User? user = await  signupUser(event.email, event.name, event.password);
        if(user != null){
          emit.call(SignUpLoadedState(user));
        }
      } catch (e) {
        emit.call(SignUpErrorState(e.toString()));
      }

      
    });
  }
}
