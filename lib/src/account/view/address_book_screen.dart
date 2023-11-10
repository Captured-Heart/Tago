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

  int radioIndex = 0;
  @override
  Widget build(BuildContext context) {
    final address = ref.watch(getAccountAddressProvider);
    final accountInfo = ref.watch(getAccountInfoProvider);

    var groupValue = address.valueOrNull?.indexWhere((element) =>
        element.streetAddress
            ?.toLowerCase()
            // .toLowerCase()
            .contains(accountInfo.valueOrNull!.address!.streetAddress!
                .toLowerCase()
                .toString()) ??
        false);
    // .where((element) => element.streetAddress!
    // .toLowerCase()
    // .contains(accountInfo.valueOrNull!.address!.streetAddress.toString()));
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: HiveHelper().getData(HiveKeys.fromCheckout.keys) ==
                HiveKeys.fromCheckout.keys
            ? TextConstant.editAddress
            : TextConstant.addressBook,
        isLeading: true,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            address.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      TextConstant.noAddressFound,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Column(
                  children: List.generate(
                    data.length,
                    (index) {
                      var addressModel = data[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio(
                            value: index,
                            groupValue: groupValue,
                            onChanged: (value) {
                              // HiveHelper().saveData(HiveKeys.addressIndex.keys, value);

                              setState(() {});
                              if (HiveHelper()
                                      .getData(HiveKeys.fromCheckout.keys) ==
                                  HiveKeys.fromCheckout.keys) {
                                //
                                //BUT HERE, THE USER IS COMING FROM A SCREEN THAT WISHES TO EDIT THE ADDRESS SUCH AS (CHECKOUT SCREEN AND HOME SCREEN)
                                ref
                                    .read(accountAddressProvider.notifier)
                                    .setDefaultAddressMethod(
                                  map: {
                                    AddressType.apartmentNumber.name:
                                        addressModel.apartmentNumber?.trim(),
                                    AddressType.city.name:
                                        addressModel.city?.trim(),
                                    AddressType.state.name:
                                        addressModel.state?.trim(),
                                    AddressType.streetAddress.name:
                                        addressModel.streetAddress?.trim(),
                                    AddressType.id.name:
                                        addressModel.id?.trim(),
                                  },
                                  context: context,
                                  ref: ref,
                                );
                                ref.invalidate(getAccountAddressProvider);
                                ref.invalidate(getAccountInfoProvider);

                                pop(context);
                              } else {
                                //
                                //HERE I AM NOT POPPING THE SCREEN, AND IT HAPPENS ONLY WHEN THE USER DIRECTLY COMES TO THE ADDRESS SCREEN
                                ref
                                    .read(accountAddressProvider.notifier)
                                    .setDefaultAddressMethod(
                                  map: {
                                    AddressType.apartmentNumber.name:
                                        addressModel.apartmentNumber?.trim(),
                                    AddressType.city.name:
                                        addressModel.city?.trim(),
                                    AddressType.state.name:
                                        addressModel.state?.trim(),
                                    AddressType.streetAddress.name:
                                        addressModel.streetAddress?.trim(),
                                    AddressType.id.name:
                                        addressModel.id?.trim(),
                                  },
                                  context: context,
                                  ref: ref,
                                );
                                ref.invalidate(getAccountAddressProvider);
                                ref.invalidate(getAccountInfoProvider);
                              }
                            },
                          ),
                          Expanded(
                            child: savedAddressCard(
                              context: context,
                              // onTap: () {
                              //   if (HiveHelper().getData(HiveKeys.fromCheckout.keys) ==
                              //       HiveKeys.fromCheckout.keys) {
                              //     HiveHelper().saveData(HiveKeys.addressId.keys, index);
                              //     ref.invalidate(getAccountAddressProvider);
                              //     pop(context);
                              //   }
                              // },
                              title:
                                  '${addressModel.apartmentNumber}, ${addressModel.streetAddress}',
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
                                      '${addressModel.apartmentNumber}, ${addressModel.streetAddress}\n${addressModel.city}\n${addressModel.state}',
                                  onPostiveAction: () {
                                    log(addressModel.id!);
                                    ref
                                        .read(accountAddressProvider.notifier)
                                        .deleteAddressMethod(
                                      map: {
                                        AddressType.id.name:
                                            addressModel.id.toString(),
                                      },
                                      context: context,
                                      ref: ref,
                                    ).whenComplete(() {
                                      popRootNavigatorTrue(
                                          context: context, value: true);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
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
