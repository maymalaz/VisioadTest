
import 'package:dart_either/dart_either.dart';

import '../../../../core/network/error/failures.dart';
import '../../data/entities/stories_param.dart';
import '../../data/entities/story_model.dart';

abstract class StoriesRepository {
  Future<Either<Failure, List<StoryModel>>> getStories(StoriesParams params);
}
