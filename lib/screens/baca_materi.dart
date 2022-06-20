import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/constant.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadMateri();
  }

  Future<void> loadMateri() async {
    String token = await getToken();
    try {
      Dio dio = Dio();
      Response response = await dio.get(baseUrl + "/api/lesson/" + widget.slug,
          options: Options(headers: {'Authorization': 'Bearer ' + token}));
      setState(() {
        data = response.data['response']['materi_sub'];
        loading = false;
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
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
            : (data[widget.index][0]['tipe'] == "materi")
                ? buildMateri()
                : buildTugas());
  }

  Widget buildMateri() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (widget.index > 0)
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BacaMateri(index: widget.index-1, slug: widget.slug)));
                      },
                      child: Text("Materi Sebelumnya"),
                      style: ElevatedButton.styleFrom(primary: Colors.amber))
                  : Container(),
              (widget.index == data.length - 1)
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BacaMateri(
                                    index: widget.index + 1,
                                    slug: widget.slug)));
                      },
                      child: Text("Materi Selanjutnya"),
                      style: ElevatedButton.styleFrom(primary: primary)),
            ],
          ),
          Text(
            data[widget.index][0]['judul'],
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(data[widget.index][0]['deskripsi'])
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
              (widget.index > 0)
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BacaMateri(
                                    index: widget.index - 1,
                                    slug: widget.slug)));
                      },
                      child: Text("Materi Sebelumnya"),
                      style: ElevatedButton.styleFrom(primary: Colors.amber))
                  : Container(),
              (widget.index == data.length - 1)
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BacaMateri(
                                    index: widget.index + 1,
                                    slug: widget.slug)));
                      },
                      child: Text("Materi Selanjutnya"),
                      style: ElevatedButton.styleFrom(primary: primary)),
            ],
          ),
          Text(
            data[widget.index][0]['judul'],
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(data[widget.index][0]['narasi'])
        ],
      ),
    );
  }
}
