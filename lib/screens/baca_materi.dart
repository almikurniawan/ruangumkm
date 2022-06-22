import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:online_course/screens/tugas_page.dart';
import 'package:online_course/screens/tugas_review.dart';
import 'package:online_course/screens/tugas_sunting_page.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BacaMateri extends StatefulWidget {
  final int index;
  final String slug;
  const BacaMateri({Key? key, required this.index, required this.slug})
      : super(key: key);

  @override
  State<BacaMateri> createState() => _BacaMateriState();
}

class _BacaMateriState extends State<BacaMateri> {
  bool loading = true;
  List<dynamic> data = [];
  List<dynamic> dataNavigasi = [];
  double posisiKiri = -210;
  int index = 0;
  late YoutubePlayerController? _controller;
  late VideoPlayerController _controllerVideo;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = index;
    loadMateri();
  }

  Future<void> loadMateri() async {
    String token = await getToken();
    try {
      Dio dio = Dio();
      Response response = await dio.get(
          baseUrl + "/api/lesson_mobile/" + widget.slug,
          options: Options(headers: {'Authorization': 'Bearer ' + token}));
      setState(() {
        data = response.data['response']['materi_tugas'];
        dataNavigasi = response.data['response']['topik'];
        loading = false;
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller!.pause();
    _controllerVideo.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controllerVideo.dispose();
    super.dispose();
  }

  Widget buildNavigation() {
    Widget menu = ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dataNavigasi[index]['judul'],
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, indexSubTopik) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          dataNavigasi[index]['subtopik'][indexSubTopik]
                              ['judul'],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, indexmateri) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                dataNavigasi[index]['subtopik'][indexSubTopik]
                                        ['content'][indexmateri]['judul'] ??
                                    "Tugas",
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: dataNavigasi[index]['subtopik'][indexSubTopik]
                              ['content']
                          .length,
                    )
                  ],
                );
              },
              itemCount: dataNavigasi[index]['subtopik'].length,
            )
          ],
        );
      },
      itemCount: dataNavigasi.length,
    );
    return menu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Baca Materi',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: (loading)
            ? Center(child: CircularProgressIndicator())
            : Stack(children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      (data[index]['tipe'] == "materi")
                          ? buildMateri()
                          : buildTugas()
                    ],
                  ),
                ),
                Positioned(
                  left: posisiKiri,
                  width: 250,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: buildNavigation(),
                        ),
                      ),
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (posisiKiri == -210) {
                              setState(() {
                                posisiKiri = 0;
                              });
                            } else {
                              setState(() {
                                posisiKiri = -210;
                              });
                            }
                          },
                          icon: (posisiKiri == -210)
                              ? Icon(Icons.menu)
                              : Icon(Icons.close),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ]));
  }

  Widget buildMateri() {
    String type = "youtube";
    late Widget componentMateri;
    if (data[index]['link_materi'] != null) {
      String? videoId =
          YoutubePlayer.convertUrlToId(data[index]['link_materi']);
      _controller = YoutubePlayerController(
        initialVideoId: videoId ?? "",
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ),
      );
      componentMateri = YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
      );
    } else {
      String file = data[index]['file'];
      List<String> nameSplit = file.split(".");
      if (nameSplit[nameSplit.length - 1] == "pdf") {
        type = "pdf";
        componentMateri = Container(
          width : double.infinity,
          height : 500,
          child: SfPdfViewer.network(
                'https://ruangumkm.ilmanaf.com/public/file_materi/'+file),
        );
      } else {
        type = "video";
        _controllerVideo = VideoPlayerController.network(
          'https://ruangumkm.ilmanaf.com/public/storage/videos/'+file,
        );

        _initializeVideoPlayerFuture = _controllerVideo.initialize();

        final chewieController = ChewieController(
          videoPlayerController: _controllerVideo,
          autoPlay: true,
          looping: true,
        );

        componentMateri = FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controllerVideo.value.aspectRatio,
                child: Chewie(
                  controller: chewieController,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (index > 0)
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          index = index - 1;
                        });
                      },
                      child: Text("Materi Sebelumnya"),
                      style: ElevatedButton.styleFrom(primary: Colors.amber))
                  : Container(),
              (index == data.length - 1)
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          index = index + 1;
                        });
                      },
                      child: Text("Materi Selanjutnya"),
                      style: ElevatedButton.styleFrom(primary: primary)),
            ],
          ),
          Text(
            data[index]['judul'],
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          componentMateri
        ],
      ),
    );
  }

  Widget buildTugas() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (index > 0)
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          index = index - 1;
                        });
                      },
                      child: Text("Materi Sebelumnya"),
                      style: ElevatedButton.styleFrom(primary: Colors.amber))
                  : Container(),
              (index == data.length - 1)
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          index = index + 1;
                        });
                      },
                      child: Text("Materi Selanjutnya"),
                      style: ElevatedButton.styleFrom(primary: primary)),
            ],
          ),
          Text(
            // data[index][0]['judul'],
            "Tugas",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    if (data[index]['flag'] == 1) {
                      return TugasPage(
                          slug: data[index]['slug'],
                          slug2: data[index]['slug2'],
                          idSub: data[index]['idSub'],
                          idFasilitator: data[index]['idFasilitator']);
                    } else if (data[index]['flag'] == 2) {
                      return TugasSuntingPage(
                          slug: data[index]['slug'],
                          slug2: data[index]['slug2'],
                          idSub: data[index]['idSub'],
                          idFasilitator: data[index]['idFasilitator']);
                    } else {
                      return TugasReview(
                          slug: data[index]['slug'],
                          slug2: data[index]['slug2'],
                          idSub: data[index]['idSub'],
                          idFasilitator: data[index]['idFasilitator']);
                    }
                  }),
                );
              },
              child: Text("Kerjakan Tugas"),
              style: ElevatedButton.styleFrom(primary: Colors.green))
        ],
      ),
    );
  }
}
