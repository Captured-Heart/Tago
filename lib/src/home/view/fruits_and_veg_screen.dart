import 'package:tago/app.dart';
import 'package:tago/src/widgets/sub_category_card.dart';

class FruitsAndVegetablesScreen extends ConsumerStatefulWidget {
  final List<dynamic> subCategoriesList;
  const FruitsAndVegetablesScreen({
    super.key,
    required this.subCategoriesList,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FruitsAndVegetablesScreenState();
}

class _FruitsAndVegetablesScreenState
    extends ConsumerState<FruitsAndVegetablesScreen> {
  //

  @override
  Widget build(BuildContext context) {
    // final categories = ref.watch(fetchCategoriesProvider);
    // final subCategory = widget.subCategoriesList;
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
                widget.subCategoriesList.length,
                growable: true,
                (index) {

                  return GestureDetector(
                  onTap: () {},
                  child: subCategoryCard(
                    context: context,
                    index: index,
                    width: context.sizeWidth(0.155),
                    height: 70,
                    subCategoriesModel: widget.subCategoriesList,
                    // subCategoriesModel: data[index].subCategories,
                  ),
                );
                },
              ),
            ).padSymmetric(horizontal: 5),
            // categories.when(
            //   data: (data) {
            //     return Wrap(
            //       runSpacing: 20,
            //       spacing: 10,
            //       alignment: WrapAlignment.start,
            //       crossAxisAlignment: WrapCrossAlignment.start,
            //       children: List.generate(
            //        data.length,
            //         growable: true,
            //         (index) => GestureDetector(
            //           onTap: () {},
            //           child: subCategoryCard(
            //             context: context,
            //             index: index,
            //             width: context.sizeWidth(0.155),
            //             height: 70,
            //             subCategoriesModel: data[index].subCategories!,
            //             // subCategoriesModel: data[index].subCategories,
            //           ),
            //         ),
            //       ),
            //     ).padSymmetric(horizontal: 5);
            //   },
            //   error: (error, stackTrace) {
            //     return Text(error.toString());
            //   },
            //   loading: () => const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
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
                      child: fruitsAndVeggiesCard(
                          index: index,
                          context: context,
                          isFreeDelivery: true,
                          indexList: [
                            0,
                            1,
                            4,
                          ])
                      // .debugBorder()
                      ),
                ),
              ),
            ).padSymmetric(horizontal: 5),
          ].columnInPadding(15)),
    );
  }
}
