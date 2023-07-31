import 'package:tago/app.dart';
import 'package:tago/utils/extensions/debug_frame.dart';

class AddNewAddressScreen extends ConsumerStatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends ConsumerState<AddNewAddressScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.addnewAddress,
        isLeading: true,
      ),
      body: Column(
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: TagoDark.scaffoldBackgroundColor,
              child: const Icon(
                Icons.my_location_outlined,
                color: TagoDark.primaryColor,
              ),
              // shape: CircleBorder(),
            ).padAll(15),
          ),
        ),
        SizedBox(
          height: context.sizeHeight(0.47),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // padding: const EdgeInsets.symmetric(horizontal: 20),

            children: [
              Expanded(
                  child: Scrollbar(
                controller: scrollController,
                interactive: true,
                child: ListView(
                  controller: scrollController,
                  children: [
                    Text(
                      TextConstant.addressDetails,
                      textAlign: TextAlign.left,
                      style: context.theme.textTheme.bodyLarge,
                    ),
                    authTextFieldWithError(
                      controller: TextEditingController(),
                      context: context,
                      isError: false,
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      hintText: TextConstant.enterAnewAddress,
                    ),
                    authTextFieldWithError(
                      controller: TextEditingController(),
                      context: context,
                      isError: false,

                      // hintText: TextConstant.enterAnewAddress,
                    ),
                    authTextFieldWithError(
                      controller: TextEditingController(),
                      context: context,
                      isError: false,
                      hintText: TextConstant.appartmentsuite,
                    ),
                    Text(
                      TextConstant.addressLabel,
                      textAlign: TextAlign.left,
                      style: context.theme.textTheme.bodyLarge,
                    ),
                    authTextFieldWithError(
                      controller: TextEditingController(),
                      context: context,
                      isError: false,
                      hintText: TextConstant.egOffice,
                    ),
                  ].columnInPadding(10),
                ),
              )),
              SizedBox(
                width: context.sizeWidth(1),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(TextConstant.saveandContinue),
                ),
              ).padSymmetric(vertical: 30)
            ],
          ).padSymmetric(horizontal: 20),
        ),
      ].columnInPadding(20)),
    );
  }
}
