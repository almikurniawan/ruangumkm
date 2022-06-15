import 'package:dio/dio.dart';
import 'package:online_course/utils/constant.dart';

class PeringkatService{
  Dio dio = Dio();
  
  Future<Map<String, dynamic>> loadPeringkat(event) async{
    try {
      String token = await getToken();
      Response response = await dio.get(baseUrl + "/api/viewPeringkat/"+event.slug,
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