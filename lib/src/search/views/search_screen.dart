import 'package:tago/app.dart';

final searchTextProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

class SearchScreen extends ConsumerWidget {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyWord = ref.watch(searchTextProvider);
    final searchList = ref.watch(fetchSearchStreamProvider(keyWord));
    return Scaffold(
      body: SafeArea(
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
                onPressed: () {},
                icon: const Icon(Icons.cancel),
              ),
            ),
            trailing: IconButton.outlined(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: TagoLight.textBold,
              ),
            ),
          ),

          Expanded(
            child: searchList.when(
              // skipError: true,
              data: (data) {
                if (data.isEmpty) {
                  return Text('Not Found');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      data.length,
                      (index) => Text(data[index].name!),
                    ).toList(),
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
                  return const Text(
                    'Type to search for a product',
                    textAlign: TextAlign.center,
                  );
                }
              },
            ),
          )
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
      ).padSymmetric(vertical: 20)),
    );
  }
}
