import 'package:chat_app_version_one/bloc_observer/simple_bloc_observer.dart';
import 'package:chat_app_version_one/pages/%20Blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app_version_one/pages/Cubits/AuthCubit/auth_cubit.dart';
import 'package:chat_app_version_one/pages/Cubits/ChatCubit/chat_cubit.dart';
import 'package:chat_app_version_one/pages/chat_page.dart';
import 'package:chat_app_version_one/pages/login_page.dart';
import 'package:chat_app_version_one/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer=SimpleBlocObserver();
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthCubit()),
        BlocProvider(create: (context)=>ChatCubit()),
        BlocProvider(create: (context)=>AuthBloc()),

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
