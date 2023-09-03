import 'package:tago/app.dart';

class FruitsAndVegetablesScreen extends ConsumerStatefulWidget {
  final List<dynamic> subCategoriesList;
  const FruitsAndVegetablesScreen({
    super.key,
    required this.subCategoriesList,
    required this.appBarTitle,
  });
  final String appBarTitle;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FruitsAndVegetablesScreenState();
}

class _FruitsAndVegetablesScreenState extends ConsumerState<FruitsAndVegetablesScreen> {
  //
  final ScrollController controller = ScrollController();
  final TextEditingControllerClass editingController = TextEditingControllerClass();
  @override
  Widget build(BuildContext context) {
    final categoryByLabel = ref.watch(fetchCategoryByLabelProvider);
    // final subCategory = widget.subCategoriesList;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.appBarTitle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: ListView(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          children: [
            authTextFieldWithError(
              controller: editingController.searchProductController,
              context: context,
              isError: false,
              filled: true,
              hintText: TextConstant.searchIn + widget.appBarTitle,
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
                    ),
                  );
                },
              ),
            ).padSymmetric(horizontal: 5),
            Text(
              '${TextConstant.all}${widget.appBarTitle}',
              style: context.theme.textTheme.bodyLarge,
            ),
            categoryByLabel.when(
              data: (data) {
                return GridView.count(
                  controller: controller,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.85,
                  children: List.generate(
                    data.length,
                    growable: true,
                    (index) {
                      return GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                            width: context.sizeWidth(0.4),
                            child: fruitsAndVeggiesCard(
                                index: index,
                                productModel: data[index],
                                context: context,
                                isFreeDelivery: true,
                                productImagesList: data[index].productImages,
                                indexList: [
                                  0,
                                  1,
                                  4,
                                ])
                            // .debugBorder()
                            ),
                      );
                    },
                  ),
                );
              },
              error: (error, _) => Center(
                child: Text(error.toString()),
              ),
              loading: () => GridView.count(
                controller: controller,
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 5,
                crossAxisSpacing: 15,
                childAspectRatio: 0.85,
                children: List.generate(
                  5,
                  (index) => fruitsAndVeggiesCardLoader(context: context),
                ),
              ),
            )
          ].columnInPadding(15)),
    );
  }
}
