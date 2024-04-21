// import 'app.dart';

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tago/app.dart';
import 'package:tago/src/onboarding/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.init();
  final ProviderContainer container = ProviderContainer(
    // This observer is used for logging changes in all Riverpod providers.
    observers: <ProviderObserver>[AppProviderObserver()],
  );

  await Firebase.initializeApp();
  initializeFBListeners();

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

void initializeFBListeners() async {
  var settings =
      await FirebaseMessaging.instance.requestPermission(alert: true, sound: true, badge: true);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User granted permission');
  } else {
    log('User declined or has not accepted permission');
  }

  var fcm = FirebaseMessaging.instance;
  fcm.subscribeToTopic('allusers');

  if (Platform.isIOS) {
    fcm.subscribeToTopic('all_ios');
  } else {
    fcm.subscribeToTopic('all_android');
  }

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    _handleNotification(message, "initialMessage");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _handleNotification(message, "listen");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _handleNotification(message, "openFromForeground");
  });
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
}

Future<void> _onBackgroundMessage(RemoteMessage? message) async {
  _handleNotification(message, "onBackground");
}

_handleNotification(RemoteMessage? message, String appStatus) async {
  log("FB AppStatus: $appStatus ");
  if (message != null) {
    //   String title = message.notification!.title!;
    // String body = message.notification!.body!;
    var decodedData = jsonDecode(message.data['data']);
    var statusType = decodedData['type'];
    var data = decodedData['data'];

    var order = HiveHelper()
        .orderListBoxValues()
        .toList()
        .firstWhere((element) => element.id == data['orderId']);

    if (statusType == "status") {
      log("order's  status update");
      order.status = data['status'];
      HiveHelper().updateSingleOrder(order);
    } else if (statusType == "location") {
      log("order's location update");
      order.rider!.latitude = data['latitude'];
      order.rider!.longitude = data['longitude'];
      HiveHelper().updateSingleOrder(order);
    }
  }
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    // bool isSeen = SharedPreferencesHelper.getOnBoardingSeen();
    return MaterialApp(
      onGenerateTitle: (context) => TextConstant.title,
      restorationScopeId: 'app',

      // useInheritedMediaQuery: true,
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
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
                return AddAddressManuallyScreen();
              default:
                return const OnBoardScreen();
            }
          },
        );
      },
    );
  }
}
