import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_visioad_app/features/stories/domain/repositories/stories_repository.dart';
import 'package:test_visioad_app/features/stories/presentation/providers/stories_notifier.dart';
import 'package:test_visioad_app/features/stories/presentation/providers/stories_state.dart';

import '../../../../core/util/injections.dart';

final storiesStateNotifierProvider =
StateNotifierProvider<StoriesNotifier, StoriesState>(
      (ref) {
    return StoriesNotifier(storiesRepo: getIt<StoriesRepository>());
  },
);
