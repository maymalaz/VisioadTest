import 'package:get_it/get_it.dart';
import 'package:test_visioad_app/core/network/dio_network.dart';

import '../../features/stories/stories_injections.dart';
import '../common feature/app_injections.dart';

final getIt = GetIt.instance;

Future<void> initInjections() async {
  await initAppInjections();
  await initCoreInjections();
  await initStoriesInjections();
}

Future<void> initCoreInjections() async {
  DioNetwork.initDio();
}
