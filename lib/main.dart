import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as fv;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_visioad_app/core/util/injections.dart';

import 'package:test_visioad_app/core/util/router.dart';
import 'package:test_visioad_app/features/stories/presentation/intro/intro_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initInjections();
  runApp(DevicePreview(
    builder: (context) {
      return const fv.ProviderScope(child: App());
    },
    enabled: false,
  ));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(

          useInheritedMediaQuery: false,
          title: 'Stories App',
          onGenerateRoute: AppRouter.generateRoute,
          // theme: appTheme,
          debugShowCheckedModeBanner: false,
          locale: const Locale("en"),
          navigatorKey: navigatorKey,
          supportedLocales: const [
            Locale("ar"),
            Locale("en"),
          ],
          home: const SplashPage(),
        );
      },
    );
  }
}
