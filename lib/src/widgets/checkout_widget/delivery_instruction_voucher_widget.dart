import 'package:tago/app.dart';

Column checkOutDeliveryInstructionsAndVoucherWidget({
  required BuildContext context,
  required AsyncValue<VoucherModel> voucherCode,
  required TextEditingControllerClass controller,
  required WidgetRef ref,
}) {
  return Column(
    children: [
      // DELIVERY INSTRUCTIONS SECTION
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.insert_drive_file_outlined,
                color: TagoLight.orange,
              ),
            ),
            Expanded(
              child: Text(
                TextConstant.deliveryInstructionsOptional,
                style: context.theme.textTheme.titleLarge,
              ),
            ),
          ].rowInPadding(8)),
      authTextFieldWithError(
        controller: controller.instructionsController,
        context: context,
        isError: false,
        inputFormatters: [],
        hintText: TextConstant.writeaNoteHint,
      ).padSymmetric(horizontal: 30),
      const Divider(thickness: 1),

      //VOUCHER SECTION
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.confirmation_num_outlined,
              color: TagoLight.orange,
            ),
            Expanded(
              child: Text(
                TextConstant.voucherCode,
                style: context.theme.textTheme.titleLarge,
              ),
            ),
          ].rowInPadding(8)),
      authTextFieldWithError(
        controller: controller.voucherController,
        context: context,
        isError: false,
        hintText: TextConstant.pastevoucherCode,
        validator: MultiValidator(
          [
            RequiredValidator(errorText: requiredValue),
            MinLengthValidator(
              6,
              errorText: passwordMustBeAtleast,
            ),
          ],
        ),
        onChanged: (value) {
          ref.read(voucherCodeProvider.notifier).update((state) => value);
        },
        suffixIcon: voucherCode.when(
          data: (data) {
            if (data.amount == null) {
              if (controller.voucherController.text.isEmpty) {
                return const SizedBox.shrink();
              }
              return const Icon(Icons.close, color: TagoLight.orange);
            } else {
              return const Icon(Icons.check, color: TagoLight.primaryColor);
            }
          },
          error: (er, _) => const Icon(Icons.close, color: TagoLight.orange),
          loading: () {
            if (controller.voucherController.text.length < 7) {
              return const SizedBox.shrink();
            }
            return const CircularProgressIndicator.adaptive();
          },
        ),
      ).padSymmetric(horizontal: 30),
      const Divider(thickness: 1)
    ].columnInPadding(10),
  );
}
