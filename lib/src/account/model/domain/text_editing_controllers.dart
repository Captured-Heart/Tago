import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:tago/app.dart';

class PaymentTextEditingControllerClass {
  final GlobalKey<FormState> addCardFormKey = GlobalKey<FormState>();

  var cardNumber = MaskedTextController(mask: '0000 0000 0000 0000 0000');
  MaskedTextController expiry = MaskedTextController(mask: '00/00');
  MaskedTextController cvv = MaskedTextController(mask: '000');

  void disposeControllers() {
    cardNumber.dispose();
    expiry.dispose();
    cvv.dispose();
  }
}
