import 'package:tago/app.dart';
import 'package:tago/src/widgets/shimmer_widget.dart';

Widget myCartListTileLoader(BuildContext context) {
  return shimmerWidget(
    child: Container(
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
            color: TagoLight.indicatorActiveColor,
          ).padOnly(left: 10),
          Expanded(
            child: ListTile(
              minLeadingWidth: 80,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              isThreeLine: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fanta Drink - 50cl Pet x 12 ',
                    style: context.theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${TextConstant.nairaSign} 1,000',
                        style: context.theme.textTheme.titleMedium,
                      ),
                    ].rowInPadding(5),
                  ),
                ].columnInPadding(10),
              ),

              //subtitle
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addMinusBTN(
                        context: context,
                        isMinus: true,
                        isDelete: false,
                        onTap: () {},
                      ),
                      Text(
                        '1',
                        style: context.theme.textTheme.titleLarge,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            visualDensity: VisualDensity.compact,
                            fixedSize: const Size.fromRadius(15),
                            minimumSize: const Size.fromRadius(15),
                            padding: EdgeInsets.zero,
                            backgroundColor:
                                TagoLight.primaryColor.withOpacity(0.15)),
                        child: const Icon(
                          Icons.add,
                          color: TagoDark.primaryColor,
                          size: 22,
                        ),
                      ),
                    ].rowInPadding(30),
                  ),
                  // .debugBorder()
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
