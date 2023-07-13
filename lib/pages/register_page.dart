import 'package:chat_app_version_one/pages/%20Blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/snackbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';
class RegisterPage extends StatelessWidget {
    String? email,password;
    static String id='registerPage';
    GlobalKey<FormState>formKey=GlobalKey();
    bool isLoading=false;

  RegisterPage({super.key});
    @override
    Widget build(BuildContext context) {
      return BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is RegisterLoading)
      {
        isLoading=true;
      }
    else if(state is RegisterSuccess)
      {
        Navigator.pushNamed(context, ChatPage.id,arguments: email);
        isLoading=false;
      }
    else if(state  is RegisterFailure)
      {
        isLoading=false;
        showSnackBar(context, state.errorMessage);
      }
  },
  builder: (context, state) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset('assets/images/scholar.png'),
                    const Text('Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: const [
                        Text('Register',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(hintText: 'example@gmail.com',
                      onChanged: (data){
                      email=data;
                      },
                    ),
                    const SizedBox(height: 10,),
                     CustomTextFormField(hintText: 'Password',
                  pass: true,
                  onChanged: (data){
                    password=data;
                  },
                ),
                    const SizedBox(height: 10,),
                    CustomButton(text: 'Register',
                      onTap: ()async {
                      if(formKey.currentState!.validate()){
                        BlocProvider.of<AuthBloc>(context).add(RegisterEvent(email: email!, password: password!));
                        }
                      }
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Text(
                            ' Sign in',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  },
);
    }


}
