import 'package:dio/dio.dart';
import 'package:online_course/utils/constant.dart';

class ProfileService {
  Dio dio = Dio();
  Future<Map<String, dynamic>> loadProfile() async {
    String token = await getToken();
    try {
      Response response = await dio.get(baseUrl + "/api/profile",
          options: Options(headers: {'Authorization': 'Bearer ' + token}));
      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi Kesalahan'};
    }
  }
}
