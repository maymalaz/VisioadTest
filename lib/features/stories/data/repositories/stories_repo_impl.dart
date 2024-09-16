import 'package:dart_either/dart_either.dart';

import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../domain/repositories/stories_repository.dart';
import '../data_sources/stories_api.dart';
import '../entities/stories_param.dart';
import '../entities/story_model.dart';

class StoriesRepositoryImpl extends StoriesRepository {
  final StoriesApi storyApi;

  StoriesRepositoryImpl(this.storyApi);

  @override
  Future<Either<Failure, List<StoryModel>>> getStories(
      StoriesParams params) async {
    try {
      final result = await storyApi.getStories(params.section);
      return Right(result.results ?? []);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
