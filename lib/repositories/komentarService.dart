import 'package:dio/dio.dart';
import 'package:online_course/blocs/komentar/komentar_event.dart';
import 'package:online_course/utils/constant.dart';

class KomentarService{
  Dio dio = Dio();
  Future<Map<String, dynamic>> loadKomentar(KomentarLoadEvent event) async{
    String token = await getToken();
    try {
      Response response = await dio.get(baseUrl + "/api/viewKomentar/"+event.slug, 
        options: Options(
          headers: {
            'Authorization': 'Bearer ' + token
          }
        )
      );
      return response.data;
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi Kesalahan'};
    }
  }

  Future<Map<String, dynamic>> sendKomen(KomentarAddEvent event) async{
    String token = await getToken();
    try {
      Response response = await dio.post(baseUrl + "/api/simpan-komentar-peserta", data: {
        'id_sub': event.idSub,
        'id_fasilitator': event.idFasilitator,
        'komentar': event.komentar,
        'aksi': event.aksi,
      }, 
        options: Options(
          headers: {
            'Authorization': 'Bearer ' + token
          }
        )
      );
      return response.data;
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi Kesalahan'};
    }
  }
}