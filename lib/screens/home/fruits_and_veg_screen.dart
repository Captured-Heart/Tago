import 'package:tago/app.dart';
import 'package:tago/utils/extensions/debug_frame.dart';

import '../../widgets/category_card.dart';

class FruitsAndVegetablesScreen extends ConsumerStatefulWidget {
  const FruitsAndVegetablesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FruitsAndVegetablesScreenState();
}

class _FruitsAndVegetablesScreenState
    extends ConsumerState<FruitsAndVegetablesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          TextConstant.fruitsAndveg,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          children: [
            authTextFieldWithError(
              controller: TextEditingController(),
              context: context,
              isError: false,
              filled: true,
              hintText: TextConstant.searchInFruitsAndVeg,
              prefixIcon: const Icon(Icons.search),
              fillColor: TagoLight.textFieldFilledColor,
            ),
            Text(
              TextConstant.chooseSubCategory,
              style: context.theme.textTheme.bodyLarge,
            ),
            Wrap(
              runSpacing: 20,
              spacing: 10,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(
                categoriesFrame.length - 5,
                growable: true,
                (index) => GestureDetector(
                  onTap: () {},
                  child: categoryCard(
                    context: context,
                    index: index,
                  ),
                ),
              ),
            ).padSymmetric(horizontal: 5),
            Text(
              TextConstant.allFruitsAndVegetables,
              style: context.theme.textTheme.bodyLarge,
            ),
            Wrap(
              runSpacing: 20,
              spacing: 5,
              alignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(
                categoriesFrame.length - 1,
                growable: true,
                (index) => GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                        width: context.sizeWidth(0.4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 1,
                              child: Image.asset(
                                categoriesFrame[index],
                                height: 140,
                                width: context.sizeWidth(1),
                                fit: BoxFit.fill,
                              ).padOnly(bottom: 4),
                            ),
                            Text(
                              categoriesFooters[index],
                              textAlign: TextAlign.center,
                              style:
                                  context.theme.textTheme.labelMedium?.copyWith(
                                fontSize: 12,
                                fontWeight: AppFontWeight.w600,
                                fontFamily: TextConstant.fontFamilyNormal,
                              ),
                            ).padSymmetric(vertical: 8),
                            Text(
                              'N1,400',
                              style: context.theme.textTheme.titleMedium
                                  ?.copyWith(
                                      fontFamily: TextConstant.fontFamilyBold,
                                      fontSize: 12),
                              textAlign: TextAlign.start,
                            )
                          ],
                        )
                        // .debugBorder()
                        )),
              ),
            ).padSymmetric(horizontal: 5),
          ].columnInPadding(15)),
    );
  }
}
