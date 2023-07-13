import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      if(event is LoginEvent)
        {
          emit(LoginLoading());
          try {
            var auth = FirebaseAuth.instance;
            UserCredential user = await auth
                .signInWithEmailAndPassword(email: event.email,
              password: event.password,);
            emit(LoginSuccess());
          } on FirebaseAuthException catch (e) {
            emit(LoginFailure(errorMessage: e.code));
          }catch(e){
            emit(LoginFailure(errorMessage: 'something went wrong!'));
          }
        }
      else if (event is RegisterEvent)
        {
            emit(RegisterLoading());
            try {
              var auth = FirebaseAuth.instance;
              await auth.createUserWithEmailAndPassword(email: event.email,
                  password: event.password);
              emit(RegisterSuccess());
            } on FirebaseAuthException catch (e) {
              emit(RegisterFailure(errorMessage: e.code));
            }catch(e){
              emit(RegisterFailure(errorMessage: 'something went wrong!'));
            }

        }
    });
  }
}
