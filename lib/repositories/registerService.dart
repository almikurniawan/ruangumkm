import 'package:dio/dio.dart';
import 'package:online_course/blocs/register/register_event.dart';
import 'package:online_course/utils/constant.dart';

class RegisterService {
  Dio dio = Dio();

  Future<Map<String, dynamic>> register(RegisterButtonPressed event) async {
    try {      
      Response response = await dio.post(baseUrl + "/api/register",
          data: FormData.fromMap({
            'profil.nama': event.nama,
            'profil.usaha': event.usaha,
            'profil.alamat': event.alamat,
            'profil.no_hp': event.hp,
            'account.email': event.email,
            'profil.instagram': event.instagram,
            'profil.facebook': event.facebook,
            'profil.shopee': event.shopee,
            'profil.tokopedia': event.tokped,
            'profil.website': event.website,
            'account.username': event.username,
            'account.password': event.password,
            'account.level': 'Peserta',
            'account.foto': await MultipartFile.fromFile(event.image!.path, filename: event.image!.path.split('/').last)
          })
        );
      return response.data;
    } catch (e) {
      return {'errorCode': 1, 'errorMessage': 'Terjadi kesalahan.'};
    }
  }
}
