import 'package:tago/screens/onboarding/onboarding.dart';
import 'package:tago/theme/app_theme.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesHelper.initSharedPref();
  final ProviderContainer container = ProviderContainer(
    // This observer is used for logging changes in all Riverpod providers.
    observers: <ProviderObserver>[AppProviderObserver()],
  );
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSeen = SharedPreferencesHelper.getOnBoardingSeen();
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          onGenerateTitle: (context) => TextConstant.title,
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: const OnBoardScreen(),
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case OnBoardScreen.routeName:
                    return const OnBoardScreen();

                  default:
                    return const OnBoardScreen();
                }
              },
            );
          },
        );
      },
      designSize: const Size(375, 812),
      scaleByHeight: true,
      minTextAdapt: true,
      child: Text('datadzfvwsvew'),
    );
  }
}
