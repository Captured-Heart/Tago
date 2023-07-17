import 'package:tago/app.dart';
import 'package:tago/screens/onboarding/add_address_screen.dart';

class ConfirmPhoneNumberScreen extends StatelessWidget {
  static const String routeName = 'confirmPhone';
  const ConfirmPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
          context: context,
          isLeading: true,
          title: TextConstant.confirmPhoneNo,
          suffixIcon: TextButton(
            onPressed: () {},
            child: const Text(TextConstant.skip),
          ),
        ),
        body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      TextConstant.wehavesent4digit,
                    ),
                    subtitle: Row(
                      children: const [
                        Text(TextConstant.enterthecode),
                        Text(' 0906736343'),
                      ],
                    ),
                  ),
                  authTextFieldWithError(
                    controller: TextEditingController(),
                    context: context,
                    isError: false,
                    hintText: TextConstant.fourdigitcode,
                  ),
                  //
                  SizedBox(
                    width: context.sizeWidth(1),
                    child: ElevatedButton(
                      onPressed: () {
                        pushNamed(context, AddAddressScreen.routeName);
                      },
                      child: const Text(TextConstant.confirm),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        TextConstant.haventreceived,
                        style: AppTextStyle.normalBodyTitle,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(TextConstant.resend),
                      )
                    ],
                  )
                ].columnInPadding(10))
            .padSymmetric(
          horizontal: context.sizeWidth(0.04),
        ));
  }
}
