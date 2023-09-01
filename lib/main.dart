// import 'app.dart';

import 'package:tago/app.dart';
import 'package:tago/src/onboarding/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesHelper.initSharedPref();
  await HiveHelper.init();
  log('started app');
  final ProviderContainer container = ProviderContainer(
    // This observer is used for logging changes in all Riverpod providers.
    observers: <ProviderObserver>[AppProviderObserver()],
  );
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
      // child: DevicePreview(
      //   enabled: kDebugMode,
      //   builder: (context) => const MainApp(),
      // ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isSeen = SharedPreferencesHelper.getOnBoardingSeen();
    return MaterialApp(
      onGenerateTitle: (context) => TextConstant.title,
      restorationScopeId: 'app',
      // useInheritedMediaQuery: true,
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const SplashScreen(),

      // const OnBoardScreen(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case OnBoardScreen.routeName:
                return const OnBoardScreen();
              case SignUpScreen.routeName:
                return const SignUpScreen();
              case SignInScreen.routeName:
                return const SignInScreen();
              case ConfirmPhoneNumberScreen.routeName:
                return ConfirmPhoneNumberScreen();
              case AddAddressScreen.routeName:
                return const AddAddressScreen();
              case AddAddressManuallyScreen.routeName:
                return const AddAddressManuallyScreen();
              default:
                return const OnBoardScreen();
            }
          },
        );
      },
    );

    // ScreenUtilInit(
    //   builder: (context, child) {
    //     return MaterialApp(
    //       onGenerateTitle: (context) => TextConstant.title,
    //       restorationScopeId: 'app',
    //       // useInheritedMediaQuery: true,
    //       // builder: DevicePreview.appBuilder,
    //       debugShowCheckedModeBanner: false,
    //       theme: lightTheme,
    //       home: const OnBoardScreen(),
    //       onGenerateRoute: (RouteSettings routeSettings) {
    //         return MaterialPageRoute<void>(
    //           settings: routeSettings,
    //           builder: (BuildContext context) {
    //             switch (routeSettings.name) {
    //               case OnBoardScreen.routeName:
    //                 return const OnBoardScreen();
    //               case SignUpScreen.routeName:
    //                 return const SignUpScreen();
    //               case SignInScreen.routeName:
    //                 return const SignInScreen();
    //               case ConfirmPhoneNumberScreen.routeName:
    //                 return const ConfirmPhoneNumberScreen();
    //               case AddAddressScreen.routeName:
    //                 return const AddAddressScreen();
    //               case AddAddressManuallyScreen.routeName:
    //                 return const AddAddressManuallyScreen();
    //               default:
    //                 return const OnBoardScreen();
    //             }
    //           },
    //         );
    //       },
    //     );
    //   },
    //   designSize: const Size(375, 812),
    //   scaleByHeight: true,
    //   minTextAdapt: true,
    //   child: Text('datadzfvwsvew'),
    // );
  }
}
