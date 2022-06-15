import 'package:dio/dio.dart';
import 'package:online_course/blocs/kelas_detail/kelas_detail_event.dart';
import 'package:online_course/utils/constant.dart';

class KelasDetailService{
  Dio dio = Dio();
  Future<Map<String, dynamic>> loadKelas(KelasDetailLoadEvent event) async{
    // String token = await getToken();
    try {
      Response response = await dio.get(baseUrl + "/api/detail/"+event.slug);
      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi Kesalahan'};
    }
  }
}