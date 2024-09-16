import 'package:test_visioad_app/core/network/dio_network.dart';
import 'package:test_visioad_app/core/network/rest_client.dart';
import 'package:test_visioad_app/features/stories/data/data_sources/stories_api.dart';


import '../../core/util/injections.dart';
import 'data/repositories/stories_repo_impl.dart';
import 'domain/repositories/stories_repository.dart';

initStoriesInjections() {
  getIt.registerFactory<StoriesApi>(
          () => StoriesApi(RestClient(DioNetwork.appAPI)));

  getIt.registerFactory<StoriesRepository>(() => StoriesRepositoryImpl(getIt()));
}
