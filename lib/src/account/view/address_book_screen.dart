import 'package:tago/app.dart';
import 'package:tago/src/account/controller/address_notifier_provider.dart';

class AddressBookScreen extends ConsumerWidget {
  const AddressBookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final address = ref.watch(getAccountAddressProvider);
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.addressBook,
        isLeading: true,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            address.when(
              data: (data) {
                return Column(
                  children: List.generate(
                    data.length,
                    (index) => savedAddressCard(
                      context: context,
                      title: '12, Adesemoye Avenue',
                      subtitle:
                          'data AdesemoyeAdesemoyeAdesemoyeAdesemoyeAdesemoyeAdesemoye',
                    ),
                  ),
                );
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) => savedAddressCard(
                //     context: context,
                //     title: '12, Adesemoye Avenue',
                //     subtitle:
                //         'data AdesemoyeAdesemoyeAdesemoyeAdesemoyeAdesemoyeAdesemoye',
                //   ),
                // );
              },
              error: (error, _) {
                return Center(
                  child: Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                    onPressed: () {
                      push(context, const AddNewAddressScreen());
                      // ref.invalidate(getAccountAddressProvider);
                      // log(HiveHelper().getData(HiveKeys.token.keys));
                    },
                    icon: const Icon(Icons.add_location_alt_outlined),
                    label: const Text(
                      TextConstant.addnewAddress,
                    )),
              ],
            ).padOnly(top: 10)
          ]
          // [

          //   savedAddressCard(
          //     context: context,
          //     title: '12, Adesemoye Avenue',
          //     subtitle:
          //         'data AdesemoyeAdesemoyeAdesemoyeAdesemoyeAdesemoyeAdesemoye',
          //   ),
          //   savedAddressCard(
          //     context: context,
          //     title: '12, Adesemoye Avenue',
          //     subtitle:
          //         'data AdesemoyeAdesemoyeAdesemoyeAdesemoyeAdesemoyeAdesemoye',
          //   ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     TextButton.icon(
          //         onPressed: () {
          //           push(context, const AddNewAddressScreen());
          //         },
          //         icon: const Icon(Icons.add_location_alt_outlined),
          //         label: const Text(
          //           TextConstant.addnewAddress,
          //         )),
          //   ],
          // ).padOnly(top: 10)
          // ],
          ),
    );
  }

  Widget savedAddressCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
  }) {
    return Container(
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: context.sizeWidth(1),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: context.sizeWidth(0.1),
          child: Row(
            children: const [
              Icon(
                Icons.location_on_outlined,
                color: TagoDark.textBold,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: context.theme.textTheme.titleMedium,
              ).padOnly(bottom: 10),
              Text(
                subtitle,
                style: context.theme.textTheme.bodyMedium,
                textAlign: TextAlign.left,
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: context.sizeWidth(0.3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onEdit,
                child: const Icon(
                  Icons.mode_edit_outline_outlined,
                  size: 22,
                  color: TagoLight.textBold,
                ),
              ).padOnly(right: 15),
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete,
                  size: 20,
                  color: TagoLight.textBold,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
