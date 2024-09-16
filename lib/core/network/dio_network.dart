import 'package:dio/dio.dart';
import '../util/constant/network_constant.dart';


class DioNetwork {
  static late Dio appAPI;

  static void initDio() {
    appAPI = Dio(baseOptions(apiUrl));
  }

  static BaseOptions baseOptions(String url) {
    return BaseOptions(
        baseUrl: url,
        validateStatus: (s) {
          return s! < 300;
        },
        headers: {},
        responseType: ResponseType.json);
  }
}
