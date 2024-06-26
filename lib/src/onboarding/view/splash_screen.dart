import 'package:tago/app.dart';

// final videoPlayerProvider = Provider((ref) {
//   return VideoPlayerController.asset(splashVideo);
// });

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isVisible = false;
  @override
  void initState() {
    super.initState();

    navigateToNexToScreen().then((_) {
      //if user == user
      if (HiveHelper().getData(HiveKeys.token.name) != null &&
          HiveHelper().getData(HiveKeys.role.name) == AuthRoleType.user.name) {
        return pushReplacement(context, const MainScreen());

        //if user == rider
      } else if (HiveHelper().getData(HiveKeys.token.name) != null &&
          HiveHelper().getData(HiveKeys.role.name) == AuthRoleType.rider.name) {
        return pushReplacement(context, const RiderHomeScreen());
      } else {
        return pushAsVoid(context, const OnBoardScreen());
      }
    });
    showLoader().then((_) {
      if (!mounted) {
        setState(() {
          isVisible = true;
        });
      }
    });
  }

  Future<void> navigateToNexToScreen() async {
    return await Future.delayed(const Duration(milliseconds: 5000));
  }

  Future<void> showLoader() async {
    return await Future.delayed(const Duration(milliseconds: 3000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: SizedBox(
              height: context.sizeHeight(0.5),
              width: context.sizeWidth(0.7),
              // aspectRatio: videoController.value.aspectRatio/0.6,
              child: Image.asset(splashVideoGif),
              // VideoPlayer(videoController),
            ),
          ),
          SizedBox(
            height: context.sizeHeight(0.2),
          ),
          Visibility(
            visible: isVisible,
            child: const CircularProgressIndicator(
              color: TagoLight.orange,
              valueColor: AlwaysStoppedAnimation(TagoDark.primaryColor),
              //  multicolor(),
            ),
          )
        ],
      ).padSymmetric(vertical: 40),
    );
  }
}
