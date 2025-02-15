

import 'package:dio/dio.dart';

import '../../../../core/common feature/data/entities/api_response_model.dart';
import '../../../../core/network/error/dio_error_handler.dart';
import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/rest_client.dart';
import '../entities/story_model.dart';

class StoriesApi {
  final RestClient restClient;

  StoriesApi(this.restClient);

  Future<ApiResponse<List<StoryModel>>> getStories(String section) async {
    try {
      final result = (await restClient.getStories(section));
      if (result.results == null) {
        throw ServerException("Unknown Error", null);
      }

      return result;
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
