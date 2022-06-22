import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_course/utils/constant.dart';

class PostResult {
  String? urlSertifikat;

  PostResult({this.urlSertifikat});

  factory PostResult.createPostResult(Map<String, dynamic> object) {
    print(object['response']['url_sertifikat']);
    return PostResult(urlSertifikat: object['response']['url_sertifikat']);
  }

  static Future<PostResult> connectToAPI(
      String? urlSertifikat, String? isWeb, int? idEvent) async {
    String token = await getToken();
    String apiUrl = baseUrl + "/api/download-sertifikat";

    var apiResult = await http.post(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer ' + token
    }, body: {
      "is_web": isWeb,
      "file_sertifikat": urlSertifikat,
      "id": "$idEvent"
    });

    var jsonObject = json.decode(apiResult.body);
    return PostResult.createPostResult(jsonObject);
  }
}
