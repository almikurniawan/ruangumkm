import 'package:dio/dio.dart';
import 'package:online_course/blocs/profile/profile_event.dart';
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

  Future<Map<String, dynamic>> update(ProfileUpdateEvent event) async {
    String token = await getToken();
    try {
      Map<String, dynamic> requestData = 
      {
        'edit_nama' : event.nama,
        'edit_email' : event.email,
        'edit_usaha' : event.usaha,
        'edit_alamat' : event.alamat,
        'edit_notelp' : event.noHp,
        'edit_instagram' : event.ig,
        'edit_facebook' : event.fb,
        'edit_tokopedia' : event.tokped,
        'edit_website' : event.website,
        'edit_shopee' : event.shopee,
      };
      if(event.password!=""){
        requestData['edit_password'] = event.password;
      }
      print(event.image);
      if(event.image != null){
        final path = event.image!.path;
        final nameFile = event.image!.path.split('/').last;
        requestData['edit_foto'] = await MultipartFile
        .fromFile(path, filename: nameFile);
      }
      Response response = await dio.post(baseUrl + "/api/profile/update",
      data: requestData,
          options: Options(headers: {'Authorization': 'Bearer ' + token}));
      return response.data['response'];
    } on DioError catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi Kesalahan'};
    }
  }
}
