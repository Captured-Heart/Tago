import 'package:tago/app.dart';

class TextEditingControllerClass {
  final GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> fruitsSearchKey = GlobalKey<FormState>();


  TextEditingController passWordController = TextEditingController();
  TextEditingController passWordController2 = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController apartmentNoController = TextEditingController();
  TextEditingController addressLabelController = TextEditingController();
  TextEditingController searchProductController = TextEditingController();
  TextEditingController searchFruitsController = TextEditingController();

  TextEditingController voucherController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  FocusNode ordersFocusNode = FocusNode();
  // TextEditingController otpCode = TextEditingController();

  void disposeControllers() {
    passWordController.dispose();
    fullNameController.dispose();
    phoneNoController.dispose();
    otpCode.dispose();
  }
}
