import 'package:tago/app.dart';

final searchFruitProvider = StateProvider(
  (ref) => '',
);

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
    final cartList = ref.watch(getCartListProvider(false)).valueOrNull;
    final search = ref.watch(searchFruitProvider);
    // final subCategory = widget.subCategoriesList;
    return FullScreenLoader(
      isLoading: ref.watch(cartNotifierProvider).isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.appBarTitle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                navBarPush(
                  context: context,
                  screen: const MyCartScreen(),
                  withNavBar: false,
                );
              },
              icon: Badge(
                backgroundColor: TagoLight.orange,
                smallSize: 10,
                isLabelVisible: cartList?.isNotEmpty ?? false,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            )
          ],
        ),
        body: ListView(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            children: [
              authTextFieldWithError(
                controller: editingController.searchFruitsController,
                context: context,
                isError: false,
                filled: true,
                hintText: TextConstant.searchIn + widget.appBarTitle,
                prefixIcon: const Icon(Icons.search),
                fillColor: TagoLight.textFieldFilledColor,
                onChanged: (p0) {
                  setState(() {});
                  ref.read(searchFruitProvider.notifier).update((state) => p0);
                },
              ),
              widget.subCategoriesList.isEmpty ||
                      editingController.searchFruitsController.value.text.isNotEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConstant.chooseSubCategory,
                          style: context.theme.textTheme.bodyLarge,
                        ).padOnly(bottom: 8),
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
                      ],
                    ),
              Text(
                '${TextConstant.all}${widget.appBarTitle}',
                style: context.theme.textTheme.bodyLarge,
              ),
              categoryByLabel.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        TextConstant.sorryNoProductsInCategory,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return GridView.count(
                    controller: controller,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.85,
                    children: List.generate(data.length, growable: true, (index) {
                      var productModel = data[index];

                      return GestureDetector(
                        onTap: () {
                          navBarPush(
                            context: context,
                            screen: SingleProductPage(
                              productsModel: productModel,
                              id: productModel.id!,
                            ),
                            withNavBar: false,
                          );
                        },
                        child: SizedBox(
                            width: context.sizeWidth(0.4),
                            child: fruitsAndVeggiesCard(
                                index: index,
                                productModel: productModel,
                                context: context,
                                isFreeDelivery: true,
                                addToCartBTN: () {
                                  if (productModel.availableQuantity! > 1) {
                                    ref.read(cartNotifierProvider.notifier).addToCartMethod(
                                      map: {
                                        ProductTypeEnums.productId.name: productModel.id.toString(),
                                        ProductTypeEnums.quantity.name: '1',
                                      },
                                    );
                                  } else {
                                    showScaffoldSnackBarMessage(
                                      TextConstant.productIsOutOfStock,
                                      isError: true,
                                    );
                                  }
                                },
                                productImagesList: data[index].productImages,
                                indexList: [
                                  0,
                                  1,
                                  4,
                                ])
                            // .debugBorder()
                            ),
                      );
                    }),
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
      ),
    );
  }
}
