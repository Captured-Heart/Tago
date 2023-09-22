import 'package:tago/app.dart';

class ReviewItemsScreen extends ConsumerWidget {
  const ReviewItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                        children: [
                  Center(
                    child: cachedNetworkImageWidget(
                        imgUrl: 'imgUrl',
                        height: context.sizeHeight(0.15),
                        width: context.sizeWidth(0.6)),
                  ),
                  Text(
                    'Coca-cola drink - pack of 6 can',
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.labelMedium
                        ?.copyWith(fontSize: 14),
                  ),
                ].columnInPadding(10))
                    .padOnly(bottom: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: 3.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 28,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const Text(TextConstant.tapStarsToGiveRatings)
                  ].columnInPadding(8),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      width: context.sizeWidth(1),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'No Issues',
                        style: context.theme.textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      width: context.sizeWidth(1),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Flawlessly awesome items. They were all in good condition and I enjoyed every bit of it. I would recommend it 100%',
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                    //
                    SizedBox(
                      width: context.sizeWidth(1),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(TextConstant.sendReview),
                      ),
                    )
                  ].columnInPadding(15),
                ).padSymmetric(horizontal: 20)
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(TextConstant.goHome),
          ).padOnly(bottom: 20)
        ],
      ),
    );
  }
}
