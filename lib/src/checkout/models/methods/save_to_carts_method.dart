import 'package:tago/app.dart';

int? cartIndexFromID(ProductsModel productsModel) {
  var cartIndex = checkCartBoxLength()?.indexWhere(
      (element) => element.product?.name?.toLowerCase() == productsModel.name?.toLowerCase());

  // ?.map((e) => e.product?.id)
  // .toList()
  // .indexOf(cartIDFromName(productsModel));
  return cartIndex;
}

int? cartQuantityFromName(ProductsModel productModel) {
  var cartIndex = checkCartBoxLength()
      ?.where((element) => element.product?.name?.toLowerCase() == productModel.name?.toLowerCase())
      .toList();

  // log('product quantity first: ${cartIndex?.map((e) => e.quantity)}, dateTime: ${DateTime.now().second}');

  if (cartIndex!.isNotEmpty) {
    // log('product quantity second: ${cartIndex.map((e) => e.quantity)}, dateTime_2nd: ${DateTime.now().second}');
    return cartIndex.map((e) => e.quantity).single;
  }

  return 1;
}

List<CartModel>? checkCartBoxLength() {
  final List<CartModel> totalLists = (HiveHelper().cartsBoxValues())
      .map((e) => CartModel(quantity: e.quantity, product: e.product))
      .toList();

  return totalLists;
}

//!   ADD RECENTLY VIEWED METHOD
void addRecentlyViewedToStorage(ProductsModel productModel) {
  // I AM GETTING THE LIST OF RECRENTLY SAVED AND PASSING THEM AS LIST
  var totalLists = (HiveHelper().recentlyBoxValues())
      //I AM ALSO ADDING A DATE TO THIS MAP, CHECK "PRODUCTSMODEL" @HIVE, YOU WILL SEE DATEIME.NOW PASSED
      .map((e) => ProductsModel(id: e.id, name: e.name))
      .toList();

//! HERE I AM CHECKING IF THE PRODUCT HAVE ALREADY BEEN SAVED TO THE DB, IF [FALSE], THEN IT IS NOT FOUND IN THE DB
  if (totalLists.map((e) => e.id).toList().contains(productModel.id) == false) {
    // this saves the recent products to list
    HiveHelper().saveRecentData(productModel.toJson());
  }
}

void saveToCartLocalStorageMethod(CartModel cartModel) {
  // final List<CartModel> recentProducts = [];
  // var products = ProductsModel()
  var totalLists = (HiveHelper().cartsBoxValues())
      .map((e) => CartModel(quantity: e.quantity, product: e.product))
      .toList();

//i am trying to check if product already exists in cart
  if (totalLists.map((e) => e.product?.id).toList().contains(cartModel.product?.id) == false) {
    // final updatedData = [...recentProducts, cartModel];
    // this saves the product to cart
    HiveHelper().saveCartsToList(cartModel.toJson());
    // this displays the "add to cart successfully" snack
    showScaffoldSnackBarMessage(TextConstant.productAddedToCartSuccessfully, duration: 1);
  } else {
    // this displays the "product already in cart" snack
    showScaffoldSnackBarMessage(TextConstant.productIsAlreadyInCart, isError: true, duration: 1);
  }
}

void incrementDecrementCartValueByIDMethod(
  int index,
  CartModel cartModel,
) {
  // final List<CartModel> recentProducts = [];

  // final updatedData = [...recentProducts, cartModel];
  HiveHelper().saveCartsToListByPutAt(index, cartModel);
}

//
void incrementDecrementCartValueMethod(
  int index,
  CartModel cartModel,
) {
  HiveHelper().saveCartsToListByPutAt(index, cartModel);
}

void deleteCartFromListMethod({
  required int index,
  required BuildContext context,
  required CartModel cartModel,
  bool? isProductModel = false,
  ProductsModel? productsModel,
  required Function setState,
}) {
  warningDialogs(
    context: context,
    title: '${TextConstant.doYouWantToDeleteThisProduct}: ',
    errorMessage: isProductModel == true
        ? '${productsModel?.name!}\n ${TextConstant.nairaSign}${productsModel?.amount}'
        : '${cartModel.product!.name!}\n ${TextConstant.nairaSign}${cartModel.product!.amount}',
    hasImage: true,
    imgUrl: isProductModel == true
        ? productsModel?.productImages!.first['image']['url']
        : cartModel.product?.productImages!.first['image']['url'],
    onPostiveAction: () {
      HiveHelper().deleteAtFromCart(index);
      popRootNavigatorTrue(context: context, value: true);
      // pop(context);
      setState;
    },
  );
}
