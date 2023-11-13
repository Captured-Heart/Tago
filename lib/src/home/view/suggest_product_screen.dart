import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:tago/app.dart';

class SuggestProductScreen extends ConsumerStatefulWidget {
  static const String routeName = 'suggestProduct';
  final CategoriesGroupModel? categoriesGroupModel;
  const SuggestProductScreen({super.key, required this.categoriesGroupModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuggestProductScreenState();
}

class _SuggestProductScreenState extends ConsumerState<SuggestProductScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  final HiveHelper helper = HiveHelper();
  // final List<String> _list = [
  //   'Developer',
  //   'Designer',
  //   'Consultant',
  //   'Student',
  // ];

  @override

  //  Product Name/Description, Category/Type (use categories provider), Brand (optional).
  Widget build(BuildContext context) {
    log(widget.categoriesGroupModel!.categories
        .map((e) => e.subCategories)
        // .where((element) => element.name!.contains('Fruits'))
        // .map((e) => e.id)
        .toList()
        .toString());
    var categoriesList = widget.categoriesGroupModel?.categories.map((e) => e.name!).toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(
        context: context,
        isLeading: true,
        title: TextConstant.suggest,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              TextConstant.welcometotago,
            ),
            subtitle: Text(
              TextConstant.groceriesDeliveryInMins,
            ),
          ).padOnly(bottom: 5),
          Form(
            key: controller.signUpformKey,
            child: Column(
              children: [
                CustomDropdown<String>(
                  hintText: 'Select Category',
                  items: categoriesList,
                  onChanged: (value) {
                    log('changing value to: $value');
                  },
                  closedBorder: Border.all(width: 0.1),
                ),
                CustomDropdown<String>(
                  hintText: 'Select brand',
                  items: categoriesList,
                  onChanged: (value) {
                    log('changing value to: $value');
                  },
                  closedBorder: Border.all(width: 0.1),
                ),
                CustomDropdown<String>(
                  hintText: 'Select product',
                  items: categoriesList,
                  onChanged: (value) {
                    log('changing value to: $value');
                  },
                  closedBorder: Border.all(width: 0.1),
                ),
              ],
            ),
          ),

          //
          SizedBox(
            width: context.sizeWidth(1),
            child: ElevatedButton(
              onPressed: () async {},
              child: const Text(TextConstant.signup),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                TextConstant.alreadyhaveacct,
                style: context.theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: AppFontWeight.w700, color: TagoLight.textBold),
              ),
              TextButton(
                onPressed: () async {
                  pushReplaceNamed(context, SignInScreen.routeName);
                },
                child: const Text(TextConstant.signIn),
              )
            ],
          ),
        ],
      ).padSymmetric(
        horizontal: context.sizeWidth(0.05),
      ),
    );
  }
}
