import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/chat/chat_bloc.dart';
import 'package:online_course/blocs/chat/chat_event.dart';
import 'package:online_course/blocs/chat/chat_state.dart';
import 'package:online_course/blocs/login/login_bloc.dart';
import 'package:online_course/blocs/login/login_state.dart';
import 'package:online_course/screens/login.dart';
import 'package:online_course/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatBloc _chatBloc;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController message = TextEditingController();
  late int idUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    loadIdUser();
  }

  loadIdUser() async {
    idUser = await getIdUser();
  }

  Future<Map<String, dynamic>> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.containsKey('token')) {
      String? token = await prefs.getString('token');
      return {"auth": true, "token": token};
    } else {
      return {"auth": false};
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
          setState(() {});
      },
      child: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          Future.delayed(const Duration(seconds: 1), () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        },
        child: Scaffold(
          body: FutureBuilder(
              future: checkAuth(),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data!;
                  if (data['auth'] == true) {
                    return Column(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<ChatBloc, ChatState>(
                            builder: (context, state) {
                              ChatLoadedState curState = state as ChatLoadedState;
                              return ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  late Alignment aligment;
                                  late Color _colors;
                                  if (idUser == curState.chats![index].idUser) {
                                    aligment = Alignment.topRight;
                                    _colors = Colors.green;
                                  } else {
                                    aligment = Alignment.topLeft;
                                    _colors = Colors.amber;
                                  }
                                  return Align(
                                    alignment: aligment,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 5),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.7,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: _colors,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              curState.chats![index].name ?? "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(curState.chats![index].message!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: curState.chats!.length,
                              );
                            },
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: message,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: "Type your message",
                                  contentPadding: EdgeInsets.all(2),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                ),
                              )),
                              IconButton(
                                  onPressed: () {
                                    _chatBloc.add(
                                        ChatSendEvent(message: message.text));
                                    message.clear();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.green,
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Login();
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
