import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({required email,required password}) async {
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
}
