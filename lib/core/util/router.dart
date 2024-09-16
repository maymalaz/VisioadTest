import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_visioad_app/features/stories/data/entities/story_model.dart';
import 'package:test_visioad_app/features/stories/presentation/pages/story_details_page.dart';

import '../../features/stories/presentation/pages/stories_page.dart';


class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      // Stories page
      case '/stories_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const StoriesPage(),
        );


    // Story details page
      case '/story_details_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            assert(settings.arguments != null, "story model is required");
            return StoryDetailsPage(
              model: settings.arguments as StoryModel,
            );
          },
        );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
