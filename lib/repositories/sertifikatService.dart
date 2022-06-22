import 'package:dio/dio.dart';
import 'package:online_course/blocs/sertifikat/sertifikat_event.dart';
import 'package:online_course/utils/constant.dart';

class SertifikatService {
  Dio dio = Dio();
  Future<Map<String, dynamic>> loadKelas(SertifikatEventLoad event) async {
    String token = await getToken();
    try {
      Response response = await dio.get(
        baseUrl + "/api/list-sertifikat",
        queryParameters: {'page': event.page, 'order': event.order},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi Kesalahan'};
    }
  }
}
