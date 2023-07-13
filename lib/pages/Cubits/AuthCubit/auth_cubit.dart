import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> registerUser({required email,required password})
  async {
    emit(RegisterLoading());
    try {
      var auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(email: email,
          password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(errorMessage: e.code));
    }catch(e){
      emit(RegisterFailure(errorMessage: 'something went wrong!'));
    }
  }
  Future<void> loginUser({required String email,required String password})
  async {
    emit(LoginLoading());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth
          .signInWithEmailAndPassword(email: email,
        password: password,);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(errorMessage: e.code));
    }catch(e){
      emit(LoginFailure(errorMessage: 'something went wrong!'));
    }
  }
}
