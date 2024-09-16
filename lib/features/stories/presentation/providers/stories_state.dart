import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_visioad_app/features/stories/data/entities/story_model.dart';

part 'stories_state.freezed.dart';

@freezed
abstract class StoriesState with _$StoriesState {
  const factory StoriesState.initial() = Initial;

  const factory StoriesState.loading() = Loading;

  const factory StoriesState.failure(String error) = Failure;

  const factory StoriesState.success(List<StoryModel> stories) = Success;


}