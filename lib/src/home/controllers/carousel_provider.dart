import 'package:tago/app.dart';

final carouselSliderProvider = Provider<CarouselController>((ref) {
  return CarouselController();
});
final currentCarouselIndexProvider = StateProvider<int>((ref) {
  return 0;
}, name: 'CAROUSEL PROVIDER');
