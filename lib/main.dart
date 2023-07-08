import 'package:chat_app_version_one/pages/Cubits/ChatCubit/chat_cubit.dart';
import 'package:chat_app_version_one/pages/Cubits/LoginCubit/login_cubit.dart';
import 'package:chat_app_version_one/pages/Cubits/RegisterCubit/register_cubit.dart';
import 'package:chat_app_version_one/pages/chat_page.dart';
import 'package:chat_app_version_one/pages/login_page.dart';
import 'package:chat_app_version_one/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>RegisterCubit()),
        BlocProvider(create: (context)=>ChatCubit()),

      ],
      child: MaterialApp(
        routes: {
          LonginPage.id: (context) => LonginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LonginPage.id,
      ),
    );
  }
}
