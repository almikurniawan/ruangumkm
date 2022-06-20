import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:online_course/models/postresult_model.dart';
import 'package:online_course/models/sertifikat_model.dart';
import 'package:online_course/theme/color.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SertifikatItem extends StatelessWidget {
  final SertifikatModel kelas;
  const SertifikatItem({Key? key, required this.kelas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? hasil;

    return Container(
      width: 90,
      height: 310,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(.1),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1),
            )
          ]),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 190,
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              imageUrl:
                  "https://ruangumkm.ilmanaf.com/public/storage/thumbnail_event/original/" +
                      this.kelas.fotoEvent!,
            ),
          ),
          Positioned(
            top: 210,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.kelas.namaEvent!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 17,
                        color: textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Color(0xfffdef2d7),
                        shadowColor: primary,
                      ),
                      onPressed: () {
                        PostResult.connectToAPI(
                                this.kelas.sertifikat!, 'false', this.kelas.id!)
                            .then((value) {
                          hasil = value.urlSertifikat;
                          openFile(
                              url: '$hasil',
                              filename: this.kelas.namaEvent! + ".pdf");
                        });
                      },
                      child: Text(
                        "Download",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openFile({required String url, String? filename}) async {
    final file = await downloadFile(url, filename!);
    if (file == null) return;

    print('Path : ${file.path}');
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}
