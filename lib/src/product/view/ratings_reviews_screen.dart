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
    // List<dynamic> listOfRatings = [3.5, 3.5, 3.8, 4.5, 4.5, 4.5, 5, 5, 5, 1, 3, 2];
    final products = ref.watch(getProductsProvider(widget.id.toString()));
    var listOfRatings = products.valueOrNull?.productReview!.map((e) => e['rating']).toList();
    log('listOfRatings: $listOfRatings');
    // var op = listOfRatings
    //     ?.where((element) => element >= 3.5 && element <= 3.5)
    //     .map((e) => e.roundToDouble())
    //     .toList();
    // log(op.toString());
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
                    '(${products.valueOrNull?.productReview?.length} ${TextConstant.verifiedRatings}) ',
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
                      '${(getAverageOfRatings(listOfDoubles: listOfRatings)?.toStringAsFixed(1) ?? 0.0)} ',
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
                    //! TODO: USE A LIST VIEW BUILDER HERE (FIXEDDDDDDDDDD)
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 5,
                      ratingsPeopleNumber:
                          getListOfIndividualRating(listOfDoubles: listOfRatings, ratingsValue: 4.5)
                              .length,
                      indicatorValue: getPercentageOfReviews(
                        totalNoOfReviews: listOfRatings!.isNotEmpty ? listOfRatings.length : 1,
                        noOfReviews: getListOfIndividualRating(
                                listOfDoubles: listOfRatings, ratingsValue: 4.5)
                            .length,
                      ),
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 4,
                      ratingsPeopleNumber:
                          getListOfIndividualRating(listOfDoubles: listOfRatings, ratingsValue: 3.5)
                              .length,
                      indicatorValue: getPercentageOfReviews(
                        totalNoOfReviews: listOfRatings?.length ?? 0,
                        noOfReviews: getListOfIndividualRating(
                                listOfDoubles: listOfRatings, ratingsValue: 3.5)
                            .length,
                      ),
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 3,
                      ratingsPeopleNumber:
                          getListOfIndividualRating(listOfDoubles: listOfRatings, ratingsValue: 2.5)
                              .length,
                      indicatorValue: getPercentageOfReviews(
                        totalNoOfReviews: listOfRatings?.length ?? 0,
                        noOfReviews: getListOfIndividualRating(
                                listOfDoubles: listOfRatings, ratingsValue: 2.5)
                            .length,
                      ),
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 2,
                      ratingsPeopleNumber:
                          getListOfIndividualRating(listOfDoubles: listOfRatings, ratingsValue: 1.5)
                              .length,
                      indicatorValue: getPercentageOfReviews(
                        totalNoOfReviews: listOfRatings?.length ?? 0,
                        noOfReviews: getListOfIndividualRating(
                                listOfDoubles: listOfRatings, ratingsValue: 1.5)
                            .length,
                      ),
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 1,
                      ratingsPeopleNumber:
                          getListOfIndividualRating(listOfDoubles: listOfRatings, ratingsValue: 0.5)
                              .length,
                      indicatorValue: getPercentageOfReviews(
                        totalNoOfReviews: listOfRatings?.length ?? 0,
                        noOfReviews: getListOfIndividualRating(
                                listOfDoubles: listOfRatings, ratingsValue: 0.5)
                            .length,
                      ),
                    ),
                    ratingsIndicatorRowWithStar(
                      context: context,
                      starValue: 0,
                      ratingsPeopleNumber:
                          getListOfIndividualRating(listOfDoubles: listOfRatings, ratingsValue: 0)
                              .length,
                      indicatorValue: getPercentageOfReviews(
                        totalNoOfReviews: listOfRatings?.length ?? 0,
                        noOfReviews:
                            getListOfIndividualRating(listOfDoubles: listOfRatings, ratingsValue: 0)
                                .length,
                      ),
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
