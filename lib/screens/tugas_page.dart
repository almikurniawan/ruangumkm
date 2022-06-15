import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/komentar/komentar_bloc.dart';
import 'package:online_course/blocs/komentar/komentar_event.dart';
import 'package:online_course/blocs/komentar/komentar_state.dart';

class TugasPage extends StatefulWidget {
  final String slug;
  final int idSub;
  final int idFasilitator;
  const TugasPage({Key? key, required this.slug, required this.idSub, required this.idFasilitator }) : super(key: key);

  @override
  State<TugasPage> createState() => _TugasPageState();
}

class _TugasPageState extends State<TugasPage> {
  late KomentarBloc _komentarBloc;
  TextEditingController komentarController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _komentarBloc = BlocProvider.of<KomentarBloc>(context);
    _komentarBloc.add(KomentarLoadEvent(slug: widget.slug));
    Timer.periodic(Duration(seconds: 15), (timer) {
      _komentarBloc.add(KomentarLoadEvent(slug: widget.slug));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tugas',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tugas 1",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Komentar",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<KomentarBloc, KomentarState>(
                      builder: (context, state) {
                        KomentarLoadedState curState =
                            state as KomentarLoadedState;
                        print(curState.komentars);
                        return MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: NetworkImage(
                                          "https://ruangumkm.ilmanaf.com/public/img/anggota/" +
                                              curState.komentars[index].fotoAnggota!),
                                      // backgroundColor: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(curState.komentars[index].namaPeserta!, style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
                                          fontWeight: FontWeight.bold
                                        )),),
                                        Text(curState.komentars[index].aksi! + " "+ curState.komentars[index].tanggal!, style: TextStyle(fontSize: 10),),
                                        Container(
                                          width: MediaQuery.of(context).size.width - 100,
                                          child: Text(curState.komentars[index].komentar!, style: TextStyle(fontSize: 16), softWrap: true, textAlign: TextAlign.left)),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: curState.komentars.length,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Masukan Komentar",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .merge(TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Text(
                              "Apakah belum jelas tentang tugas, bisa mengajukan pertanyaan kepada fasilitator"),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: komentarController,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: "Komentar",
                              contentPadding: EdgeInsets.all(2),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.green)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.green)),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _komentarBloc.add(KomentarAddEvent(idSub: widget.idSub, idFasilitator: widget.idFasilitator, komentar: komentarController.text));
                                komentarController.clear();
                              },
                              child: Text("Kirim"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
