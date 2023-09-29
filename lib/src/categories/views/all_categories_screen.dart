import 'package:tago/app.dart';

class AllCategoriesScreen extends ConsumerStatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends ConsumerState<AllCategoriesScreen> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final categoriesGroup = ref.watch(fetchCategoriesProvider);
    final cartList = ref.watch(getCartListProvider(false)).valueOrNull;

    return Scaffold(
      appBar: categoriesAppbar(
        context: context,
        isBadgeVisible: cartList?.isNotEmpty ?? false,
      ),
      body: ListView(
        controller: controller,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          categoriesGroup.when(
            data: (data) {
              return GridView.count(
                  controller: controller,
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,

                  // padding: const EdgeInsets.symmetric(horizontal: 5),
                  shrinkWrap: true,
                  children: List.generate(
                    data!.categories.length,
                    growable: true,
                    (index) => GestureDetector(
                      onTap: () {
                        ref.read(categoryLabelProvider.notifier).update(
                            (state) => data.categories[index].label ?? '');
                        push(
                          context,
                          FruitsAndVegetablesScreen(
                            subCategoriesList:
                                data.categories[index].subCategories,
                            appBarTitle:
                                data.categories[index].name ?? 'Product Name',
                          ),
                        );
                      },
                      child: categoryCard(
                        context: context,
                        index: index,
                        width: context.sizeWidth(0.28),
                        height: 100,
                        categoriesModel: data.categories[index],
                      ),
                    ),
                  ));
            },
            //TODO: ADD CACHED MODEL HERE
            error: (error, stackTrace) => Center(child: Text(NetworkErrorEnums.checkYourNetwork.message)),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
