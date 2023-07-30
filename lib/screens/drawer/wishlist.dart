import 'package:tago/app.dart';
import 'package:tago/utils/extensions/debug_frame.dart';
import 'package:tago/widgets/fruits_veggies_card.dart';

class WishListScreen extends ConsumerWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.mywishlist,
        isLeading: true,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          wishlistWidget(
            context: context,
            isPriceCancelled: false,
            images: drinkImages[2],
          ),
          wishlistWidget(
            context: context,
            isPriceCancelled: true,
            images: drinkImages[3],
          ),
          wishlistWidget(
            context: context,
            isPriceCancelled: true,
            images: drinkImages[5],
          ),
        ],
      ),
    );
  }

  Container wishlistWidget(
      {required BuildContext context,
      bool? isPriceCancelled,
      required String images}) {
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
          Image.asset(
            images,
            height: 100,
            width: 100,
            fit: BoxFit.fill,
          ),
          Expanded(
            child: ListTile(
              minLeadingWidth: 80,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              isThreeLine: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fanta Drink - 50cl Pet x 12',
                    style: context.theme.textTheme.bodySmall,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isPriceCancelled == true
                          ? Text(
                              'N1,879',
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(
                                      decoration: TextDecoration.lineThrough),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        'N1,879',
                        style: context.theme.textTheme.titleMedium,
                      ),
                    ].rowInPadding(5),
                  ),
                ]
                .columnInPadding(10),
              ),

              //subtitle
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        color: TagoDark.orange,
                      ),
                      Text(
                        '3.5',
                        style: context.theme.textTheme.bodyLarge,
                      ),
                      Text(
                        '(123)',
                        style: context.theme.textTheme.bodyMedium,
                      ),
                    ].rowInPadding(5),
                  ),
                  isPriceCancelled == true
                      ? ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(25),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: Text(
                            TextConstant.addtocart,
                            style: context.theme.textTheme.bodyLarge?.copyWith(
                              color: TagoDark.scaffoldBackgroundColor,
                            ),
                          ),
                        )
                      : Row(
                          // mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            addMinusBTN(
                              context: context,
                              isMinus: true,
                              onTap: () {},
                            ),
                            Text(
                              '2',
                              style: context.theme.textTheme.titleLarge,
                            ),
                            addMinusBTN(
                              context: context,
                              isMinus: false,
                              onTap: () {},
                            ),
                          ].rowInPadding(15),
                        )
                        // .debugBorder()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
