import 'package:dio/dio.dart';
import 'package:online_course/blocs/tugas/tugas_event.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_event.dart';
import 'package:online_course/utils/constant.dart';

class TugasService {
  Dio dio = Dio();

  Future<Map<String, dynamic>> sendSuntingJawaban(
      Map<dynamic, dynamic> requestData) async {
    print(requestData);
    try {
      String token = await getToken();
      Response response = await dio.post(baseUrl + "/api/sunting-tugas",
          data: requestData,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      
      return response.data;
    } on DioError catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Unauthenticated'};
    }
  }

  Future<Map<String, dynamic>> sendJawaban(
      Map<dynamic, dynamic> requestData) async {
    try {
      String token = await getToken();
      Response response = await dio.post(baseUrl + "/api/pelaksanaan-tugas",
          data: requestData,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      
      return response.data;
    } on DioError catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Unauthenticated'};
    }
  }

  Future<Map<String, dynamic>> loadTugas(TugasLoadEvent event) async {
    try {
      String token = await getToken();
      Response response = await dio.get(
          baseUrl + "/api/viewTugas/" + event.slug,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return response.data;
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Unauthenticated'};
    }
  }

  Future<Map<String, dynamic>> loadSoal(TugasSubmitLoadEvent event) async {
    try {
      String token = await getToken();
      Response response = await dio.get(
          baseUrl + "/api/pelaksanaan-tugas/" + event.slug1 + '/' + event.slug2,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Unauthenticated'};
    }
  }

  Future<Map<String, dynamic>> loadSuntingSoal(TugasSubmitLoadSuntingEvent event) async {
    try {
      String token = await getToken();
      Response response = await dio.get(
          baseUrl + "/api/sunting-tugas/" + event.slug1 + '/' + event.slug2,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Unauthenticated'};
    }
  }

  Future<Map<String, dynamic>> loadReview(TugasSubmitLoadReviewEvent event) async{
    try {
      String token = await getToken();
      Response response = await dio.get(
          baseUrl + "/api/review-tugas/" + event.slug1 + '/' + event.slug2,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return response.data['response'];
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Unauthenticated'};
    }

    return {};
  }
}
