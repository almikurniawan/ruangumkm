import 'package:dio/dio.dart';
import 'package:online_course/utils/constant.dart';

class DashboardService {
  Dio dio = Dio();

  Future<Map<String, dynamic>> loadDashboard() async {
    try {
      Response response = await dio.get(baseUrl + "/api/dashboard");

      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Username/Password Salah'};
    }
  }
}
