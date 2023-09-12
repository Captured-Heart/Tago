import 'package:tago/app.dart';

class TextEditingControllerClass {
  final GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInformKey = GlobalKey<FormState>();

  TextEditingController passWordController = TextEditingController();
  TextEditingController passWordController2 = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController apartmentNoController = TextEditingController();
  TextEditingController addressLabelController = TextEditingController();
  TextEditingController searchProductController = TextEditingController();
  TextEditingController voucherController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();


  // TextEditingController otpCode = TextEditingController();

  void disposeControllers() {
    passWordController.dispose();
    fullNameController.dispose();
    phoneNoController.dispose();
    otpCode.dispose();
  }
}
