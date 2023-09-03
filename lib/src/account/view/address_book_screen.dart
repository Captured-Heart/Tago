import 'package:tago/app.dart';
import 'package:tago/src/account/loaders/address_book_loader.dart';

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
      body: ListView(padding: const EdgeInsets.symmetric(horizontal: 20), children: [
        address.when(
          data: (data) {
            return Column(
              children: List.generate(
                data.length,
                (index) {
                  var addressModel = data[index];
                  return savedAddressCard(
                    context: context,
                    onTap: () {
                      push(
                        context,
                        AddNewAddressScreen(
                          addressModel: addressModel,
                          isEditMode: true,
                        ),
                      );
                    },
                    title: '${addressModel.apartmentNumber}, ${addressModel.streetAddress}',
                    subtitle: addressModel.city ?? '',
                    subtitle2: addressModel.state ?? '',
                    onEdit: () {
                      log(addressModel.id!);
                    },
                    onDelete: () {
                      warningDialogs(
                        context: context,
                        title: TextConstant.areSureYouWantToDelete,
                        errorMessage:
                            '''${addressModel.apartmentNumber}, ${addressModel.streetAddress}
${addressModel.city}
${addressModel.state}
                                ''',
                        onPostiveAction: () {
                          log(addressModel.id!);
                          ref.read(accountAddressProvider.notifier).deleteAddressMethod(
                            map: {
                              AddressType.id.name: addressModel.id.toString(),
                            },
                            context: context,
                            ref: ref,
                          ).whenComplete(() {
                            popRootNavigatorTrue(context);
                          });
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
          error: (error, _) {
            return Center(
              child: Text(
                error.toString(),
                textAlign: TextAlign.center,
              ),
            );
          },
          loading: () => savedAddressCardLoader(context: context),
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
      ]),
    );
  }
}
