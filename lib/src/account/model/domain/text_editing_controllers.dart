import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:tago/app.dart';

class PaymentTextEditingControllerClass {
  final GlobalKey<FormState> addCardFormKey = GlobalKey<FormState>();

  TextEditingController cardNameController = TextEditingController();
  var cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000 0000');
  MaskedTextController expiryController = MaskedTextController(mask: '00/00');
  MaskedTextController cvvController = MaskedTextController(mask: '000');

  void disposeControllers() {
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
  }
}
