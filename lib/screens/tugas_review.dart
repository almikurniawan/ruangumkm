import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/komentar/komentar_bloc.dart';
import 'package:online_course/blocs/komentar/komentar_event.dart';
import 'package:online_course/blocs/komentar/komentar_state.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_bloc.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_event.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_state.dart';
import 'package:online_course/theme/color.dart';

class TugasReview extends StatefulWidget {
  final String slug;
  final String slug2;
  final int idSub;
  final int idFasilitator;
  const TugasReview(
      {Key? key,
      required this.slug,
      required this.slug2,
      required this.idSub,
      required this.idFasilitator})
      : super(key: key);

  @override
  State<TugasReview> createState() => _TugasReviewState();
}

class _TugasReviewState extends State<TugasReview> {
  late KomentarBloc _komentarBloc;
  late TugasSubmitBloc _tugasSubmitBloc;
  TextEditingController komentarController = TextEditingController();

  List<TextEditingController> _controller = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _komentarBloc = BlocProvider.of<KomentarBloc>(context);
    _tugasSubmitBloc = BlocProvider.of<TugasSubmitBloc>(context);
    _komentarBloc.add(KomentarLoadEvent(slug: widget.slug));
    _tugasSubmitBloc
        .add(TugasSubmitLoadReviewEvent(slug1: widget.slug, slug2: widget.slug2));
    // Timer.periodic(Duration(seconds: 15), (timer) {
    //   _komentarBloc.add(KomentarLoadEvent(slug: widget.slug));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TugasSubmitBloc, TugasSubmitState>(
      listener: (context, state) {
        if(state is TugasSubmitFinishState){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<TugasSubmitBloc, TugasSubmitState>(
            builder: (context, state) {
              if (state is TugasSubmitLoadedState) {
                return Text(
                  state.judulTugas!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                );
              }
              return Text("Review Tugas", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black));
            },
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
                      BlocBuilder<TugasSubmitBloc, TugasSubmitState>(
                        builder: (context, state) {
                          if (state is TugasSubmitLoadedState) {
                            return Text(state.judulTugas!,
                                style: Theme.of(context).textTheme.subtitle1);
                          }
                          return Text("Tugas",
                              style: Theme.of(context).textTheme.subtitle1);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<TugasSubmitBloc, TugasSubmitState>(
                        builder: (context, state) {
                          if (state is TugasSubmitLoadedState) {
                            return MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return  Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.soal![index].soal!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("Jawaban : "+state.jawabanPeserta![index]),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ]),
                                    );
                                  
                                },
                                itemCount: state.soal!.length,
                              ),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
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
                                                curState.komentars[index]
                                                    .fotoAnggota!),
                                        // backgroundColor: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (curState.komentars[index].aksi=="PESERTA") ? 
                                            curState
                                                .komentars[index].namaPeserta! : "Fasilitator",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .merge(TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                          Text(
                                            curState.komentars[index].aksi! +
                                                " " +
                                                curState
                                                    .komentars[index].tanggal!,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  100,
                                              child: Text(
                                                  curState
                                                      .komentars[index].komentar!,
                                                  style: TextStyle(fontSize: 16),
                                                  softWrap: true,
                                                  textAlign: TextAlign.left)),
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
