import 'package:dio/dio.dart';
import 'package:hacker_news/misc/constants.dart';

class ClientHelper {
  static Dio getClient(String baseUrl) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Constants.timeoutDuration,
      receiveTimeout: Constants.timeoutDuration,
      sendTimeout: Constants.timeoutDuration,
    );
    final dioClient = Dio(
      options,
    );

    return dioClient;
  }
}
