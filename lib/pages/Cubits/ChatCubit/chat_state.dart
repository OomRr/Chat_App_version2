part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class Success extends ChatState {
  List<Message>messages;

  Success({required this.messages});
}

