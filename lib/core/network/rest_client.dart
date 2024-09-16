import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/stories/data/entities/story_model.dart';
import '../common feature/data/entities/api_response_model.dart';
import '../util/constant/network_constant.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  @GET("{section}.json?api-key=$apiKey")
  Future<ApiResponse<List<StoryModel>>> getStories(
      @Path() String section);
}