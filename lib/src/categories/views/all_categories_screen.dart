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
    final categories = ref.watch(fetchCategoriesProvider);
    return Scaffold(
      appBar: categoriesAppbar(context),
      body: ListView(
        controller: controller,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          categories.when(
            data: (data) {
              return GridView.count(
                  controller: controller,
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,

                  // padding: const EdgeInsets.symmetric(horizontal: 5),
                  shrinkWrap: true,
                  children: List.generate(
                    data.length,
                    growable: true,
                    (index) => GestureDetector(
                      onTap: () {
                        var subList = data[index].subCategories;
                        log(subList.toString());
                        push(
                          context,
                          FruitsAndVegetablesScreen(
                            subCategoriesList: subList!,
                            appBarTitle: data[index].name ?? 'Product Name',
                          ),
                        );
                      },
                      child: categoryCard(
                        context: context,
                        index: index,
                        width: context.sizeWidth(0.28),
                        height: 100,
                        categoriesModel: data[index],
                      ),
                    ),
                  ));
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
