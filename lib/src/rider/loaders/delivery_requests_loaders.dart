import 'package:tago/app.dart';
import 'package:tago/src/widgets/shimmer_widget.dart';

Widget riderOrdersListTileLoaders({
  required BuildContext context,
  required int index,
}) {
  return shimmerWidget(
    child: ListView.builder(
        itemCount: index,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.1),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(left: 10),
                  color: TagoLight.indicatorActiveColor,
                ),
                Expanded(
                  child: ListTile(
                    minLeadingWidth: 80,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    isThreeLine: true,
                    title: const LinearProgressIndicator(
                      minHeight: 30,
                      value: 0.5,
                    ).padOnly(bottom: 5, right: 30),

                    //subtitle
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: context.sizeWidth(0.36),
                            child: const LinearProgressIndicator(
                              minHeight: 10,
                              value: 0.8,
                            ),
                          ),
                          SizedBox(
                            width: context.sizeWidth(0.3),
                            child: const LinearProgressIndicator(
                              minHeight: 10,
                              value: 0.8,
                            ),
                          ),

                          // IS DELIVERY REQUESTS == TRUE

                          Row(
                              children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: TagoLight.primaryColor,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(
                                TextConstant.acceptRequest,
                                style: AppTextStyle.listTileTitleLight.copyWith(
                                  color: TagoLight.scaffoldBackgroundColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            //
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: TagoLight.primaryColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                TextConstant.viewdetails,
                                style: AppTextStyle.listTileTitleLight.copyWith(
                                  color: TagoLight.scaffoldBackgroundColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ].rowInPadding(8))

                          // .debugBorder()
                        ].columnInPadding(8)),
                  ),
                ),
              ],
            ),
          );
        }),
  );
}
