import 'package:tago/app.dart';

void addSearchToLocal(ProductsModel productModel) {
  var totalLists = (HiveHelper().getAllSearchEntries())
      .map((e) => ProductsModel(name: e.name, id: e.id))
      .toList();

  if (totalLists.map((e) => e.name).toList().contains(productModel.name) == false) {
    HiveHelper().saveSearchData(productModel.toJson());
  }
}

Future<void> deleteDataAtIndex(int index) async {
  if (index >= 0) {
    HiveHelper().deleteSearchAtIndex(index);
  }
}

void navigateToSingleProductScreen(
    {required BuildContext context,
    required WidgetRef ref,
    required ProductsModel searchObject,
    required TextEditingController controller}) {
  ref.read(searchIsLoadingProvider.notifier).update((state) => true);

  ref.read(getProductsProvider(searchObject.label ?? '').future).then((value) {
    ref.read(searchIsLoadingProvider.notifier).update((state) => false);
    // pop(context);
    controller.clear();
    navBarPush(
      context: context,
      screen: SingleProductPage(
        id: value.id ?? 0,
        productsModel: value,
      ),
      withNavBar: false,
    );
  });
}
