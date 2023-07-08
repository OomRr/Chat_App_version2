import 'package:chat_app_version_one/helper/snackbar.dart';
import 'package:chat_app_version_one/pages/Cubits/ChatCubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../models/message.dart';
import '../widgets/chat_bubble.dart';
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id='chat page';
  String gdata='';
  final _controller=ScrollController();
  TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments as String ;

      return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kLogo,height: 50),
                  const Text('Chat',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            body: BlocBuilder<ChatCubit, ChatState>(
  builder: (context, state) {
    var messagesList=BlocProvider.of<ChatCubit>(context).messagesList;
    return Container(
              color: const Color(0xff176B87),
              child: Column(
                children: [
                  Expanded(child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context,index)
                        {
                          return messagesList[index].id==email? ChatBubble(
                          message: messagesList[index],
                          ):ChatBubbleForFriend(message: messagesList[index]);
                        }
                      ),
                    ),),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: TextField(
                      controller: controller,
                      onChanged: (data){
                        gdata=data;
                      },
                      onSubmitted:(data)
                      {
                        if (data!='') {
                          BlocProvider.of<ChatCubit>(context).sendMessage(email: email, data: data);
                          controller.clear();
                          _controller.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffDAFFFB),
                        suffixIcon: IconButton(icon: const Icon(Icons.send_rounded),
                            onPressed: ()
                            {
                              if(gdata!='')
                                {
                                  BlocProvider.of<ChatCubit>(context).sendMessage(email: email, data: gdata);
                                  controller.clear();
                                  gdata='';
                                }
                            },
                        ),
                        suffixIconColor: kPrimaryColor,
                        hintText: 'Enter a message',
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
  },
),
          );

  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}