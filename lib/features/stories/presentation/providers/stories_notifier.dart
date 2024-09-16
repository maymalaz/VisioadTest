import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_visioad_app/features/stories/data/entities/stories_param.dart';
import 'package:test_visioad_app/features/stories/data/entities/story_model.dart';
import 'package:test_visioad_app/features/stories/domain/repositories/stories_repository.dart';
import 'package:test_visioad_app/features/stories/presentation/providers/stories_state.dart';



class StoriesNotifier extends StateNotifier<StoriesState> {
  final StoriesRepository storiesRepo;

  List<StoryModel> allStories = [];

  StoriesNotifier({
    required this.storiesRepo,
  }) : super(const StoriesState.initial());

  Future<void> getStories(StoriesParams params, {String? text}) async {
    state = const StoriesState.loading();

    final response = await storiesRepo.getStories(params);

    state =await response.fold(ifLeft:
        (failure) {
      return StoriesState.failure(failure.errorMessage);
    }
        , ifRight:   (stories) async {
        allStories = stories;
        return StoriesState.success(allStories);
      },
    );





  }


}