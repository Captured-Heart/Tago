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
      return push(context, const OnBoardScreen());
    });
    showLoader().then((_) {
      setState(() {
        isVisible = true;
      });
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
