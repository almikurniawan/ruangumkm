import 'package:dio/dio.dart';
import 'package:online_course/utils/constant.dart';

class LoginService {
  Dio dio = Dio();

  Future<void> logout() async{
    try {
      Response response = await dio.post(baseUrl + "/api/logout",
        options: Options(
          headers: {
            "Authorization" : "Bearer " + await getToken()
          }
        )
      );
    } catch (e) {
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      Response response = await dio.post(baseUrl + "/api/login",
          data: {'email': username, 'password': password});
      if (response.statusCode == 401) {
        return {'errorCode': 1, 'errorMessage': response.data['message']};
      } else {
        return {
          'errorCode': 0,
          'errorMessage': '',
          'token': response.data['access_token'],
          'id_user': response.data['id_user'],
          'name' : response.data['name']
        };
      }
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Username/Password Salah'};
    }
  }
}
