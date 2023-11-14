import 'package:tago/app.dart';

final searchTextProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final searchIsLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class MyData {
  final List<String> dataList;

  MyData(this.dataList);
}

class SearchScreen extends ConsumerWidget {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  SearchScreen({super.key});

  void _addStringToList(ProductsModel productModel) {
    var totalLists = (HiveHelper().getAllSearchEntries())
        .map((e) => ProductsModel(name: e.name, id: e.id))
        .toList();

    // log(totalLists.map((e) => e.name).toList().toString());

    if (totalLists.map((e) => e.name).toList().contains(productModel.name) == false) {
      // this saves the recent products to list

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // log(HiveHelper().containsSearchData(HiveKeys.search.keys).toString());
    final keyWord = ref.watch(searchTextProvider);
    final searchList = ref.watch(fetchSearchStreamProvider(keyWord));
    // log('serachList: ${searchList.valueOrNull?.map((e) => e.label).toList()}');

    return FullScreenLoader(
      isLoading: ref.watch(searchIsLoadingProvider),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: controller.fruitsSearchKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  minLeadingWidth: 5,
                  horizontalTitleGap: 3,
                  leading: const BackButton(),
                  title: authTextFieldWithError(
                    controller: controller.searchProductController,
                    context: context,
                    prefixIcon: const Icon(Icons.search),
                    isError: false,
                    autoFocus: true,
                    filled: true,
                    onChanged: (value) {
                      ref.read(searchTextProvider.notifier).update((state) => value);
                    },
                    suffixIcon: IconButton.outlined(
                      onPressed: () {
                        controller.searchProductController.clear();
                        ref.read(searchTextProvider.notifier).update((state) => '');
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ),
                ),
                Expanded(
                  child: searchList.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textBaseline: TextBaseline.alphabetic,
                                children: const [
                                  Icon(
                                    Icons.cancel_outlined,
                                    size: 18,
                                    color: TagoLight.textHint,
                                  ),
                                  Text(
                                    TextConstant.productNotFound,
                                    textAlign: TextAlign.end,
                                    textScaleFactor: 1.1,
                                  )
                                ].rowInPadding(5))
                            .padSymmetric(vertical: 20);
                      } else {
                        return ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(data.length, (index) {
                              var searchObject = data[index];
                              return ListTile(
                                onTap: () {
                                  // controller.fruitsSearchKey.currentState!.save();
                                  _addStringToList(searchObject);
                                  navigateToSingleProductScreen(
                                    context: context,
                                    ref: ref,
                                    searchObject: searchObject,
                                    controller: controller.searchProductController,
                                  );
                                  // ref
                                  //     .read(searchIsLoadingProvider.notifier)
                                  //     .update((state) => true);

                                  // ref
                                  //     .read(getProductsProvider(searchObject.label ?? '').future)
                                  //     .then((value) {
                                  //   ref
                                  //       .read(searchIsLoadingProvider.notifier)
                                  //       .update((state) => false);
                                  //   pop(context);
                                  //   navBarPush(
                                  //     context: context,
                                  //     screen: SingleProductPage(
                                  //       id: value.id ?? 0,
                                  //       productsModel: value,
                                  //     ),
                                  //     withNavBar: false,
                                  //   );
                                  // });
                                },
                                title: Text(
                                  searchObject.name!,
                                  style: AppTextStyle.normalBodyTitle,
                                ),
                                shape: const Border(
                                  bottom: BorderSide(
                                    width: 0.3,
                                    style: BorderStyle.solid,
                                    color: TagoLight.textFieldBorder,
                                  ),
                                ),
                              );
                            }).toList(),

                            // i commented out the SEE ALL BUTTON because there is no screen/ intentions for it
                            //! see all search button
                            // TextButton(
                            //   onPressed: () {},
                            //   child: const Text(
                            //     TextConstant.seeAllResults,
                            //     textScaleFactor: 0.9,
                            //   ),
                            // ).padSymmetric(horizontal: 10, vertical: 10)
                          ],
                        );
                      }
                    },
                    error: (e, _) => Center(
                      child: Text(e.toString()),
                    ),
                    loading: () {
                      if (keyWord.isNotEmpty && keyWord.length > 2) {
                        return const Center(child: CircularProgressIndicator.adaptive());
                      } else if (keyWord.isNotEmpty && keyWord.length < 3) {
                        return const Text(
                          'Search keyword must be greater than 3 characters',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        // if it contains in hive data
                        // if (HiveHelper().containsSearchData(HiveKeys.search.keys) == true) {
                        if (HiveHelper().getAllSearchEntries().isNotEmpty) {
                          return Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(child: Text(TextConstant.recentSearches)),
                                TextButton(
                                  onPressed: () {
                                    HiveHelper().clearBoxSearch();
                                  },
                                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                  child: const Text(TextConstant.clear),
                                )
                              ],
                            ).padOnly(left: 20, right: 5),

                            //valueable listener for hive searches
                            ValueListenableBuilder(
                              valueListenable: HiveHelper().getSearchListenable(),
                              builder:
                                  (BuildContext context, Box<ProductsModel> box, Widget? child) {
                                // final myData = HiveHelper()
                                //     .getDataSearch(defaultValue: box) as List<String>;
                                if (box.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                List<ProductsModel> products = box.values.toList();

                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: box.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile(
                                        onTap: () {
                                          navigateToSingleProductScreen(
                                            context: context,
                                            ref: ref,
                                            searchObject: products[index],
                                            controller: controller.searchProductController,
                                          );
                                        },
                                        title: Text(
                                          products[index].name!,
                                          style: AppTextStyle.listTileSubtitleLight,
                                        ),
                                        shape: const Border(
                                          bottom: BorderSide(
                                            width: 0.3,
                                            style: BorderStyle.solid,
                                            color: TagoLight.textFieldBorder,
                                          ),
                                        ),
                                        minLeadingWidth: 1,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            deleteDataAtIndex(index);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 20,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                          ]);
                        } else {
                          return Column(
                                  children: const [
                            Icon(
                              Icons.shopping_basket_outlined,
                              color: TagoLight.textFieldBorder,
                              size: 40,
                            ),
                            Text(
                              'Type to search for a product',
                              textAlign: TextAlign.center,
                            ),
                          ].columnInPadding(15))
                              .padSymmetric(vertical: 40);
                        }
                      }
                    },
                  ),
                ),
              ],
            ).padSymmetric(vertical: 20),
          ),
        ),
      ),
    );
  }
}
