import 'package:tago/app.dart';

Row carouselIndicator(BuildContext context, int length, WidgetRef ref) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      length,
      (index) => GestureDetector(
        onTap: () => ref.read(carouselSliderProvider).animateToPage(index),
        child: Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.symmetric(
            // vertical: 8.0,
            horizontal: 4.0,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (Theme.of(context).brightness == Brightness.dark
                    ? TagoLight.indicatorInactiveColor
                    : TagoLight.indicatorActiveColor)
                .withOpacity(
              ref.watch(currentCarouselIndexProvider) == index ? 0.9 : 0.4,
            ),
          ),
        ),
      ),
    ),
  );
}
