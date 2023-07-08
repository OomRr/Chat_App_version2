import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

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
