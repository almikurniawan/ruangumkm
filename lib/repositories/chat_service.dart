import 'package:firebase_database/firebase_database.dart';
import 'package:online_course/blocs/chat/chat_event.dart';
import 'package:online_course/utils/constant.dart';

class ChatService {
  
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference().child('messages');

  Query getMessageQuery() {
    return _messagesRef;
  }

  void sendMessage(ChatSendEvent event) async{
    String userName = await getUser();
    int idUser = await getIdUser();
    String now =
        DateTime.now().millisecondsSinceEpoch.toString() + idUser.toString();

    getMessageQuery().reference().child(now).set({
      "message": event.message,
      "created_at": DateTime.now().toString(),
      "user_id" : idUser,
      "user_name" : userName
    }).asStream();
  }
}
