import 'package:tago/app.dart';

import '../home/controllers/value_notifier.dart';
import 'fruits_veggies_card.dart';

Widget myCartListTile(BuildContext context, WidgetRef ref) {
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
            drinkImages[3],
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
                    'Fanta Drink - 50cl Pet x 12 Fanta Drink Fanta Drink',
                    style: context.theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'N1,879',
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
                  ValueListenableBuilder(
                    valueListenable: ref.watch(valueNotifierProvider),
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          addMinusBTN(
                            context: context,
                            isMinus: true,
                            isDelete: value < 2 ? true : false,
                            onTap: () {
                              if (value > 1) {
                                ref.read(valueNotifierProvider).value--;
                              }
                            },
                          ),
                          Text(
                            value.toString(),
                            style: context.theme.textTheme.titleLarge,
                          ),
                          addMinusBTN(
                            context: context,
                            isMinus: false,
                            onTap: () {
                              ref.read(valueNotifierProvider).value++;
                            },
                          ),
                        ].rowInPadding(30),
                      );
                    },
                  ),
                  // .debugBorder()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
