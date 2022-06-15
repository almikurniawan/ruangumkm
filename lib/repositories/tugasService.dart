import 'package:dio/dio.dart';
import 'package:online_course/blocs/tugas/tugas_event.dart';
import 'package:online_course/utils/constant.dart';

class TugasService{
  Dio dio = Dio();

  Future<Map<String, dynamic>> loadTugas(TugasLoadEvent event) async {
    try {
      String token = await getToken();
      Response response = await dio.get(baseUrl + "/api/viewTugas/"+event.slug,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token
          }
        )
      );

      return response.data;
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Unauthenticated'};
    }
  }
}