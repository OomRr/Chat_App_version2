import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app_version_one/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message>messagesList=[];
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  void sendMessage({required String email,required String data})
  {
    try {
      messages.add({
        kMessage:data,
        kCreatedAt:DateTime.now(),
        'id':email,
      });
    }catch (e) {

    }
  }
  void receiveMessage()
    {
      messages.orderBy(kCreatedAt,descending: true).snapshots().listen((event)
      {
        messagesList.clear();
        for (var doc in event.docs) {
          messagesList.add(Message.fromJson(doc));
        }
        emit(Success(messages: messagesList));
      });
    }
}
