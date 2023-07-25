import 'package:tago/app.dart';
import 'package:tago/utils/extensions/debug_frame.dart';

import '../../widgets/category_card.dart';

class AllCategoriesScreen extends ConsumerStatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends ConsumerState<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          TextConstant.allcategories,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Wrap(
            runSpacing: 20,
            spacing: 10,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
              categoriesFrame.length ,
              growable: true,
              (index) => GestureDetector(
                  onTap: () {},
                  child: categoryCard(
                    context: context,
                    index: index,
                    width: context.sizeWidth(0.28),
                    height: 100,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
