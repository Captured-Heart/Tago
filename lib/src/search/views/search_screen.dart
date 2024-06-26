import 'package:hive_flutter/hive_flutter.dart';
import 'package:tago/app.dart';

final searchTextProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

class MyData {
  final List<String> dataList;

  MyData(this.dataList);
}

class SearchScreen extends ConsumerWidget {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  SearchScreen({super.key});
  final List<String> recentStrings = [];

  void _addStringToList(String value) {
    final myData = HiveHelper()
        .getDataSearch(key: HiveKeys.search.keys, defaultValue: recentStrings) as List<String>;
    log('myData: $myData');
    // recentStrings.add(value);
    final updatedData = [...myData, value];
    HiveHelper().saveSearchData(HiveKeys.search.keys, updatedData);
  }

  Future<void> deleteDataAtIndex(int index) async {
    final myData = HiveHelper()
        .getDataSearch(key: HiveKeys.search.keys, defaultValue: recentStrings) as List<String>;

    if (index >= 0 && index < myData.length) {
      myData.removeAt(index);
      HiveHelper().saveSearchData(HiveKeys.search.keys, myData);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log(HiveHelper().containsSearchData(HiveKeys.search.keys).toString());
    final keyWord = ref.watch(searchTextProvider);
    final searchList = ref.watch(fetchSearchStreamProvider(keyWord));
    log('serachList: $searchList');
    return Scaffold(
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(data.length, (index) {
                            var searchObject = data[index];
                            return ListTile(
                              onTap: () {
                                // controller.fruitsSearchKey.currentState!.save();
                                _addStringToList(searchObject.name ?? 'o');

                                // navBarPush(
                                //   context: context,
                                //   screen: SearchFilterScreen(
                                //     controller: controller,
                                //     product: data,
                                //   ),
                                //   withNavBar: false,
                                //   popFirst: true,
                                // );
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

                          //see all search button
                          TextButton(
                            onPressed: () {
                              // controller.fruitsSearchKey.currentState!.save();

                              // navBarPush(
                              //   context: context,
                              //   screen: SearchFilterScreen(
                              //     controller: controller,
                              //     product: data,
                              //   ),
                              //   withNavBar: false,
                              //   popFirst: true,
                              // );
                            },
                            child: const Text(
                              TextConstant.seeAllResults,
                              textScaleFactor: 0.9,
                            ),
                          ).padSymmetric(horizontal: 10, vertical: 10)
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
                      if (HiveHelper().containsSearchData(HiveKeys.search.keys) == true) {
                        return Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: Text(TextConstant.recentSearches)),
                              TextButton(
                                onPressed: () {
                                  log('message');
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
                            builder: (BuildContext context, Box box, Widget? child) {
                              final myData = HiveHelper().getDataSearch(
                                  key: HiveKeys.search.keys,
                                  defaultValue: recentStrings) as List<String>;
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: myData.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        //TODO: PUSH JUST THE SELECETD TO THE NEXT SCREEN
                                        // controller.searchProductController.text = myData[index];
                                        // controller.fruitsSearchKey.currentState!.save();

                                        // navBarPush(
                                        //   context: context,
                                        //   screen: SearchFilterScreen(
                                        //     controller: controller,
                                        //   ),
                                        //   withNavBar: false,
                                        // );
                                      },
                                      title: Text(
                                        myData[index],
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

              // ValueListenableBuilder(
              //   valueListenable: HiveHelper().getSearchListenable(),
              //   builder: (context, value, child) {
              //     return ListView.builder(
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //         return ListTile(
              //           title: Text('data home'),
              //           trailing: IconButton(
              //             onPressed: () {},
              //             icon: Icon(Icons.close),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ).padSymmetric(vertical: 20),
        ),
      ),
    );
  }
}
