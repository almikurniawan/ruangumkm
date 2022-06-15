import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/chat/chat_event.dart';
import 'package:online_course/blocs/chat/chat_state.dart';
import 'package:online_course/models/message.dart';
import 'package:online_course/repositories/chat_service.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoadedState(chats: [], isLoading: true)) {
    ChatService _chatService = ChatService();

    _chatService.getMessageQuery().onChildAdded.listen((event) {
      var value = event.snapshot.value;
      add(ChatMessageAddedEvent(Message(
          idUser: value['user_id'],
          message: value['message'],
          name: value['user_name'])));
    });

    on<ChatMessageAddedEvent>((event, emit) {
      ChatLoadedState curState = state as ChatLoadedState;
      emit(curState.addChat(chats : event.message).copyFrom(isLoading: false));
    });

    on<ChatSendEvent>((event, emit) {
      ChatLoadedState curState = state as ChatLoadedState;
      curState = curState.copyFrom(isLoading: true);
      emit(curState);
      _chatService.sendMessage(event);
      curState = curState.copyFrom(isLoading: false);
      emit(curState);
    });
  }
}
