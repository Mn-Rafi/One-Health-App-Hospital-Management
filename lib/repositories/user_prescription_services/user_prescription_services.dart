import 'package:dio/dio.dart';
import 'package:one_health_hospital_app/repositories/api_utilities.dart';

class UserPrescriptionServices {
  Future<Response> getAllPrescriptions({
    required String token,
    required String userId,
  }) async {
    Dio dio = Dio();
    dio.options.headers["auth-token"] = token;
    Response response = await dio.get(
      '${ApiUtilities.baseUrl}/prescription/$userId',
    );
    return response;
  }
}
