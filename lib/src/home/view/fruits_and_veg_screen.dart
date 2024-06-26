import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tago/app.dart';

final searchFruitProvider = StateProvider(
  (ref) => '',
);

class FruitsAndVegetablesScreen extends ConsumerStatefulWidget {
  final List<SubCategoryModel>? subCategoriesList;
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
  final TextEditingControllerClass editingController = TextEditingControllerClass();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  var currentPosition = 0;

  void _scrollToItem(int index) {
    itemScrollController.scrollTo(
        index: index, duration: const Duration(seconds: 2), curve: Curves.easeInOutCubic);
  }

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(() {
      ItemPosition? itemPosition = itemPositionsListener.itemPositions.value.first;
      setState(() {
        currentPosition = itemPosition.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryWithSubcategories = ref.watch(fetchCategoryWithSubcategoriesByLabelProvider);
    // final search = ref.watch(searchFruitProvider);
    // final subCategory = widget.subCategoriesList;
    // log(checkCartBoxLength().toString());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.appBarTitle,
              ),
              GestureDetector(
                  onTap: () => push(context, SearchScreen()),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search_outlined,
                    ),
                  )),
            ],
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
                isLabelVisible: checkCartBoxLength()?.isNotEmpty ?? false,

                // isLabelVisible: cartList?.isNotEmpty ?? false,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            )
          ],
        ),
        body: Container(
          color: TagoDark.scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                height: 50,
                child: ListView.builder(
                  itemCount: widget.subCategoriesList!.length,
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _scrollToItem(index);
                      },
                      child: subCategoryCardItem(widget.subCategoriesList![index].name, index),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: categoryWithSubcategories.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return const Center(
                          child: Text(
                            TextConstant.sorryNoProductsInCategory,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return ScrollablePositionedList.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          bool isLast = index == data.length - 1;

                          return subCategoryWithProductsCard(data[index], isLast: isLast);
                        },
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                      );
                    },
                    error: (error, _) => Center(
                      child: Text(NetworkErrorEnums.checkYourNetwork.message),
                    ),
                    loading: () => ListView.builder(
                      itemCount: 2,
                      shrinkWrap: false,
                      itemBuilder: (context, index) {
                        return fruitsAndVeggiesCardLoader(context: context);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  subCategoryCardItem(String name, int index) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: currentPosition == index ? TagoDark.primaryColor : null,
          border:
              Border.all(color: currentPosition == index ? TagoDark.primaryColor : Colors.black87)),
      child: Text(
        name,
        style: context.theme.textTheme.titleSmall?.copyWith(
            fontFamily: TextConstant.fontFamilyNormal,
            fontSize: 12,
            color: currentPosition == index ? Colors.white : TagoDark.textBold),
      ),
    ).padOnly(left: 10);
  }

  subCategoryWithProductsCard(SubCategoryModel subCategoryModel, {bool isLast = false}) {
    return subCategoryModel.products!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subCategoryModel.name,
                style: context.theme.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 0.6,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  subCategoryModel.products!.length,
                  (index) {
                    var productModel = subCategoryModel.products![index];
                    var quantity = cartQuantityFromName(productModel);

                    return productCard(
                      productModel: subCategoryModel.products![index],
                      context: context,

                      // on DECREMENT
                      onDecrementBTN: () {
                        if (quantity! > 1) {
                          //! REDUCE THE QUANTITY
                          incrementDecrementCartValueMethod(
                            cartIndexFromID(productModel)!,
                            CartModel(quantity: quantity - 1, product: productModel),
                          );
                        } else {
                          //! delete from the cart locally
                          deleteCartFromListMethod(
                            index: cartIndexFromID(productModel)!,
                            cartModel: CartModel(),
                            context: context,
                            setState: () {},
                            isProductModel: true,
                            productsModel: productModel,
                          );
                          // setState(() {});
                          //! DELETE FROM THE CART IN BACKEND
                          ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                            map: {
                              ProductTypeEnums.productId.name: productModel.id.toString(),
                            },
                          ).whenComplete(
                            () => ref.invalidate(getCartListProvider(false)),
                          );
                        }
                      },

                      //ON INCREMENT
                      onIncrementBTN: () {
                        if (quantity! < productModel.availableQuantity!) {
                          log('increased: ${cartIndexFromID(productModel)!} ');

                          incrementDecrementCartValueMethod(
                            cartIndexFromID(productModel)!,
                            CartModel(quantity: quantity + 1, product: productModel),
                          );
                        } else {
                          showScaffoldSnackBarMessage(
                            'The available quantity of ${productModel.name} is (${productModel.availableQuantity})',
                            isError: true,
                            duration: 2,
                          );
                        }
                      },
                      addToCartBTN: () {
                        if (subCategoryModel.products![index].availableQuantity! < 1) {
                          //product is out of stock
                          showScaffoldSnackBarMessage(
                            TextConstant.productIsOutOfStock,
                            isError: true,
                          );
                        } else {
                          //add to cart (LOCALLY)
                          saveToCartLocalStorageMethod(
                            CartModel(quantity: 1, product: subCategoryModel.products![index]),
                          );
                          // add to cart (BACKEND)
                          ref.read(cartNotifierProvider.notifier).addToCartMethod(
                            map: {
                              ProductTypeEnums.productId.name:
                                  subCategoryModel.products![index].id.toString(),
                              ProductTypeEnums.quantity.name: '1',
                            },
                          );
                          ref.invalidate(getCartListProvider(false));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ).padOnly(bottom: isLast ? 350 : 35)
        : const SizedBox();
  }
}
