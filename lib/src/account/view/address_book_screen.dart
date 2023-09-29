import 'package:tago/app.dart';
import 'package:tago/src/account/loaders/address_book_loader.dart';

class AddressBookScreen extends ConsumerStatefulWidget {
  const AddressBookScreen({super.key});

  @override
  ConsumerState<AddressBookScreen> createState() => AddressBookScreenState();
}

class AddressBookScreenState extends ConsumerState<AddressBookScreen> {
  @override
  void dispose() {
    HiveHelper().saveData(HiveKeys.fromCheckout.keys, 'value');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final address = ref.watch(getAccountAddressProvider);

    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: HiveHelper().getData(HiveKeys.fromCheckout.keys) == HiveKeys.fromCheckout.keys
            ? TextConstant.editAddress
            : TextConstant.addressBook,
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
                      //TODO: ADD THIS GENERAL ON TAP TO A RADIO WIDGET TO SELECT DEFAULT ADDRESS
                      if (HiveHelper().getData(HiveKeys.fromCheckout.keys) ==
                          HiveKeys.fromCheckout.keys) {
                        HiveHelper().saveData(HiveKeys.addressId.keys, index);
                        ref.invalidate(getAccountAddressProvider);
                        pop(context);
                      }
                    },
                    title: '${addressModel.apartmentNumber}, ${addressModel.streetAddress}',
                    subtitle: addressModel.city ?? '',
                    subtitle2: addressModel.state ?? '',
                    onEdit: () {
                      push(
                        context,
                        AddNewAddressScreen(
                          addressModel: addressModel,
                          isEditMode: true,
                        ),
                      );
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
            return const Center(
              child: Text(
                TextConstant.noAddressFound,
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
