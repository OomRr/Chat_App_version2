import 'package:chat_app_version_one/pages/Cubits/ChatCubit/chat_cubit.dart';
import 'package:chat_app_version_one/pages/Cubits/LoginCubit/login_cubit.dart';
import 'package:chat_app_version_one/pages/chat_page.dart';
import 'package:chat_app_version_one/pages/register_page.dart';
import 'package:chat_app_version_one/widgets/custom_button.dart';
import 'package:chat_app_version_one/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/snackbar.dart';
class LonginPage extends StatelessWidget {
  String? email, password;
  static String id = 'LoginPage';
  bool isLoading = false;
  bool isShow = false;
  GlobalKey<FormState>formKey = GlobalKey();

  LonginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {

        if(state is LoginLoading)
          {
            isLoading=true;
          }
        else if (state is LoginSuccess)
        {
          BlocProvider.of<ChatCubit>(context).receiveMessage();
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
        }
        else if(state is LoginFailure)
          {

            showSnackBar(context, state.errorMessage);
          }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading = false,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                        Text('Sign in',
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
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(hintText: 'Password',
                      pass: true,
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomButton(text: 'Sign in',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).loginUser(email: email!, password: password!);
                        }
                      },
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dont have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: const Text(
                            ' register',
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
      ),
    );
  }


}
