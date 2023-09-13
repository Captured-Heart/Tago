import 'package:tago/app.dart';

class RatingsAndReviewsScreen extends ConsumerStatefulWidget {
  final int id;
  const RatingsAndReviewsScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RatingsAndReviewsState();
}

class _RatingsAndReviewsState extends ConsumerState<RatingsAndReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(getProductsProvider(widget.id.toString()));

    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.ratingandReviews,
        isLeading: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TextConstant.averageRating,
                    style: context.theme.textTheme.titleMedium,
                  ),
                  Text(
                    '(17 ${TextConstant.verifiedRatings}) ',
                    style: context.theme.textTheme.bodyLarge,
                  ),
                ].rowInPadding(10),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: TagoDark.orange,
                      size: 25,
                    ),
                    Text(
                      '4.5',
                      style: context.theme.textTheme.bodyLarge,
                      textScaleFactor: 1.6,
                    )
                  ].rowInPadding(10)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 5,
                      ratingsPeopleNumber: 15,
                      indicatorValue: 0.9,
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 4,
                      ratingsPeopleNumber: 2,
                      indicatorValue: 0.2,
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 3,
                      ratingsPeopleNumber: 0,
                      indicatorValue: 0.0,
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 2,
                      ratingsPeopleNumber: 0,
                      indicatorValue: 0.0,
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 1,
                      ratingsPeopleNumber: 0,
                      indicatorValue: 0.0,
                    ),
                  ].columnInPadding(10),
                ),
              ),
            ].columnInPadding(12),
          ),

          // user comment
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${TextConstant.userComments}(${products.valueOrNull?.productReview?.length})',
                style: context.theme.textTheme.bodyLarge,
                textScaleFactor: 1.15,
              ),
              products.when(
                data: (data) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1, strokeAlign: BorderSide.strokeAlignInside),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...List.generate(
                          data.productReview?.length ?? 1,
                          (index) => ratingsCard(
                            context: context,
                            productsModel: products,
                            index: index,
                          ),
                        )
                      ],
                    ),
                  );
                },
                error: (err, _) => Text(err.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ].columnInPadding(15),
          ).padSymmetric(vertical: 20)
        ],
      ),
    );
  }

  Row ratingsIndicatorRowWithStar({
    required BuildContext context,
    required double indicatorValue,
    required int starValue,
    required int ratingsPeopleNumber,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          starValue.toString(),
          style: context.theme.textTheme.titleMedium,
        ),
        const Icon(
          Icons.star,
          color: TagoDark.orange,
          size: 18,
        ).padOnly(left: 5),
        Text(
          '($ratingsPeopleNumber)',
          style: context.theme.textTheme.bodyLarge,
        ).padSymmetric(horizontal: 15),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: indicatorValue,
              color: TagoDark.primaryColor,
              backgroundColor: TagoDark.textHint,
              minHeight: 5,
            ),
          ),
        )
      ],
    );
  }
}
