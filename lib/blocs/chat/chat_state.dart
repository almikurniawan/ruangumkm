import 'package:online_course/models/message.dart';
import 'package:online_course/utils/constant.dart';

abstract class ChatState{}

class ChatLoadedState extends ChatState{
  List<Message>? chats = [];
  bool? isLoading = true;

  ChatLoadedState({
    this.chats,
    this.isLoading
  });

  ChatLoadedState copyFrom({List<Message>? chats, bool? isLoading}){
    return ChatLoadedState(
      chats: chats ?? this.chats, 
      isLoading: isLoading ?? this.isLoading
    );
  }

  ChatLoadedState addChat({required Message chats}){
    List<Message>? currentChats = this.chats;
    currentChats!.add(chats);
    return ChatLoadedState(
      chats: currentChats,
      isLoading: this.isLoading
    );
  }


}