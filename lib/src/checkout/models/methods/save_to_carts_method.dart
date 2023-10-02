import 'package:tago/app.dart';

List<CartModel>? checkCartBoxLength() {
  final List<CartModel> totalLists = (HiveHelper().cartsBoxValues())
      .map((dynamic e) => CartModel(quantity: e[0].quantity, product: e[0].product))
      .toList();

  return totalLists;
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
  required Function setState,
}) {
  warningDialogs(
    context: context,
    title: '${TextConstant.doYouWantToDeleteThisProduct}: ',
    errorMessage:
        '${cartModel.product!.name!}\n ${TextConstant.nairaSign}${cartModel.product!.amount}',
    hasImage: true,
    imgUrl: cartModel.product!.productImages!.first['image']['url'],
    onPostiveAction: () {
      HiveHelper().deleteAtFromCart(index);
      pop(context);
      setState;
    },
  );
}
