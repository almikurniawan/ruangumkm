import 'package:dio/dio.dart';
import 'package:online_course/blocs/kelas_saya/kelas_event.dart';
import 'package:online_course/utils/constant.dart';

class KelasService{
  Dio dio = Dio();
  Future<Map<String, dynamic>> loadKelas(KelasEventLoad event) async{
    String token = await getToken();
    try {
      Response response = await dio.get(baseUrl + "/api/listview/items", 
        queryParameters: {
          'page': event.page,
          'jenis': event.type,
          'order': event.order
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ' + token
          }
        )
      );
      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi Kesalahan'};
    }
  }

  Future<Map<String, dynamic>> loadKelasAll(KelasEventLoadAll event) async{
    try {
      Response response = await dio.get(baseUrl + "/api/list/items", 
        queryParameters: {
          'page': event.page,
          'jenis': event.type,
          'order': event.order,
          'search': event.search
        },
      );
      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi Kesalahan'};
    }
  }
}