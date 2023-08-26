import 'package:tago/app.dart';
import 'package:video_player/video_player.dart';

final videoPlayerProvider = Provider((ref) {
  return VideoPlayerController.asset(splashVideo);
});

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isVisible = false;
  @override
  void initState() {
    final videoController = ref.read(videoPlayerProvider);

    super.initState();

    navigateToNexToScreen().then((_) {
      return push(context, const OnBoardScreen());
    });
    showLoader().then((_) {
      setState(() {
        isVisible = true;
      });
    });
    videoController.initialize().then((_) {});
    videoController.play();
    if (videoController.value.duration == const Duration(seconds: 4)) {
      videoController.pause();
    }
    videoController.setLooping(true);
  }

  Future<void> navigateToNexToScreen() async {
    return await Future.delayed(const Duration(milliseconds: 5000));
  }

  Future<void> showLoader() async {
    return await Future.delayed(const Duration(milliseconds: 3000));
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(videoPlayerProvider).dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoController = ref.watch(videoPlayerProvider);
    // log(videoController.value.toString());
    // Color multicolor() {
    //   Color? setColor;
    //   for (var i = 0; i < Colors.primaries.length; i++) {
    //     // return Colors.primaries[i];
    //     setState(() {
    //       setColor = Colors.primaries[i];
    //     });
    //   }
    //   return setColor!;
    // }

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //  {
        //   // return Colors.primaries[i];
        //   setState(() {
        //     setColor = Colors.primaries[i];
        //   });
        // }
        Center(
          child: SizedBox(
            height: context.sizeHeight(0.5),
            width: context.sizeWidth(0.7),
            // aspectRatio: videoController.value.aspectRatio/0.6,
            child: 
            VideoPlayer(videoController),
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
    ).padSymmetric(vertical: 40));
  }
}
