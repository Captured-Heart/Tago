import 'package:tago/app.dart';

class CheckBoxWidget extends ConsumerStatefulWidget {
  final bool checkBoxValue;
  final ValueChanged<bool> onChanged;
  const CheckBoxWidget({
    super.key,
    required this.checkBoxValue,
    required this.onChanged,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CheckBoxWidgetState();
}

class CheckBoxWidgetState extends ConsumerState<CheckBoxWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox.adaptive(
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value ?? false;
          widget.onChanged(value ?? false);
        });
      },
      tristate: true,
      checkColor: TagoDark.primaryColor.withOpacity(0.6),
      activeColor: TagoDark.primaryColor.withOpacity(0.2),
    );
  }
}

Widget myCartListTile(
    {required BuildContext context,
    required WidgetRef ref,
    required CartModel cartModel,
    required VoidCallback onDelete,
    VoidCallback? onTap,
    Widget? checkbox,
    bool? checkBoxValue,
    Function(bool?)? onChanged,
    Key? key}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      key: key,
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox.adaptive(
              //   value: checkBoxValue,
              //   onChanged: onChanged,
              //   tristate: true,
              //   checkColor: TagoDark.primaryColor.withOpacity(0.6),
              //   activeColor: TagoDark.primaryColor.withOpacity(0.2),
              // ),
              CheckBoxWidget(
                checkBoxValue: checkBoxValue ?? false,
                onChanged: onChanged ?? (value) {},
              ),

              cachedNetworkImageWidget(
                imgUrl: cartModel.product?.productImages?.last['image']['url'],
                height: 100,
              ),
            ],
          ),
          Expanded(
            child: ListTile(
              minLeadingWidth: 80,
              // contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              isThreeLine: true,

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartModel.product!.name!,
                    // 'Fanta Drink - 50cl Pet x 12 Fanta Drink Fanta Drink',
                    style: context.theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    TextConstant.nairaSign +
                        cartModel.product!.amount.toString(),
                    // 'N1,879',
                    style: context.theme.textTheme.titleMedium,
                  ),
                ].columnInPadding(10),
              ),

              //subtitle
              subtitle: ValueListenableBuilder(
                valueListenable:
                    ref.watch(valueNotifierProvider(cartModel.quantity!)),
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      addMinusBTN(
                        context: context,
                        isMinus: true,
                        isDelete: value < 2 ? true : false,
                        onTap: () {
                          if (value > 1) {
                            ref
                                .read(
                                    valueNotifierProvider(cartModel.quantity!))
                                .value--;
                          } else {
                            onDelete();
                          }
                        },
                      ),
                      Text(
                        value.toString(),
                        style: context.theme.textTheme.titleLarge,
                      ),
                      addMinusBTN(
                        context: context,
                        isMinus: false,
                        onTap: () {
                          ref
                              .read(valueNotifierProvider(cartModel.quantity!))
                              .value++;
                        },
                      ),
                    ].rowInPadding(15),
                  );
                },
              ),
              //  Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     ValueListenableBuilder(
              //       valueListenable: ref.watch(
              //         valueNotifierProvider(cartModel.quantity!),
              //       ),
              //       builder: (context, value, child) {
              //         return Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             addMinusBTN(
              //               context: context,
              //               isMinus: true,
              //               isDelete: value < 2 ? true : false,
              //               onTap: () {
              //                 if (value > 1) {
              //                   ref.read(valueNotifierProvider(cartModel.quantity!)).value--;
              //                 } else {
              //                   onDelete();
              //                 }
              //               },
              //             ),
              //             Text(
              //               value.toString(),
              //               style: context.theme.textTheme.titleLarge,
              //             ),
              //             addMinusBTN(
              //               context: context,
              //               isMinus: false,
              //               onTap: () {
              //                 ref.read(valueNotifierProvider(cartModel.quantity!)).value++;
              //               },
              //             ),
              //           ].rowInPadding(30),
              //         );
              //       },
              //     ),
              //     // .debugBorder()
              //   ],
              // ),
            ),
          ),
        ],
      ),
    ),
  );
}
