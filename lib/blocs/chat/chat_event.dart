import 'package:online_course/models/message.dart';

abstract class ChatEvent{}

class ChatMessageAddedEvent extends ChatEvent{
  final Message message;
  ChatMessageAddedEvent(this.message);
}

class ChatSendEvent extends ChatEvent{
  final String message;
  ChatSendEvent({required this.message});
}