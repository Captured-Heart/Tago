import 'package:tago/app.dart';

int? cartIDFromName(ProductsModel productsModel) {
  var cartID = checkCartBoxLength()
      ?.where(
          (element) => element.product?.name?.toLowerCase() == productsModel.name?.toLowerCase())
      .map((e) => e.product?.id)
      .first;

  return cartID;
}

int? cartIndexFromID(ProductsModel productsModel) {
  var cartIndex = checkCartBoxLength()
      ?.map((e) => e.product?.id)
      .toList()
      .indexOf(cartIDFromName(productsModel));
  return cartIndex;
}

int? cartQuantityFromName(ProductsModel productModel) {
  var cartIndex = checkCartBoxLength()
      ?.where((element) => element.product?.name?.toLowerCase() == productModel.name?.toLowerCase())
      .toList();
  if (cartIndex!.isNotEmpty) {
    return cartIndex.map((e) => e.quantity).first;
  }
  // .map((e) => e.quantity)
  // .first;

  return 1;
}

List<CartModel>? checkCartBoxLength() {
  final List<CartModel> totalLists = (HiveHelper().cartsBoxValues())
      .map((dynamic e) => CartModel(quantity: e[0].quantity, product: e[0].product))
      .toList();

  return totalLists;
}

void addRecentlyViewedToStorage(ProductsModel productModel) {
  final List<ProductsModel> recentProducts = [];
  var totalLists = (HiveHelper().recentlyBoxValues())
      .map((dynamic e) => ProductsModel(id: e[0].id, name: e[0].name))
      .toList();

  if (totalLists.map((e) => e.id).toList().contains(productModel.id) == false) {
    final updatedData = [...recentProducts, productModel];
    // this saves the recent products to list
    HiveHelper().saveRecentData(updatedData);
  }
}

void saveToCartLocalStorageMethod(CartModel cartModel) {
  final List<CartModel> recentProducts = [];
  var totalLists = (HiveHelper().cartsBoxValues())
      .map((dynamic e) => CartModel(quantity: e[0].quantity, product: e[0].product))
      .toList();

//i am trying to check if product already exists in cart
  if (totalLists.map((e) => e.product?.id).toList().contains(cartModel.product?.id) == false) {
    final updatedData = [...recentProducts, cartModel];
    // this saves the product to cart
    HiveHelper().saveCartsToList(updatedData);
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
  final List<CartModel> recentProducts = [];

  final updatedData = [...recentProducts, cartModel];
  HiveHelper().saveCartsToListByPutAt(index, updatedData);
}

//
void incrementDecrementCartValueMethod(
  int index,
  CartModel cartModel,
) {
  final List<CartModel> recentProducts = [];

  final updatedData = [...recentProducts, cartModel];
  HiveHelper().saveCartsToListByPutAt(index, updatedData);
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
