import 'package:tago/app.dart';

class TextEditingControllerClass {
  final GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changePassformKey = GlobalKey<FormState>();

  final GlobalKey<FormState> signInformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> fruitsSearchKey = GlobalKey<FormState>();

  TextEditingController passWordController = TextEditingController();
  TextEditingController passWordController2 = TextEditingController();
  TextEditingController oldPassWordController = TextEditingController();
  TextEditingController newPassWordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController apartmentNoController = TextEditingController();
  TextEditingController addressPostalController = TextEditingController();
  TextEditingController searchProductController = TextEditingController();
  TextEditingController searchFruitsController = TextEditingController();

  TextEditingController voucherController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  FocusNode ordersFocusNode = FocusNode();
  FocusNode phoneNoFocusMode = FocusNode();
  FocusNode passwordFocusMode = FocusNode();

  fieldFocusChange(
    BuildContext context, {
    required FocusNode currentFocus,
    required FocusNode nextFocus,
  }) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // TextEditingController otpCode = TextEditingController();

  void disposeControllers() {
    passWordController.dispose();
    fullNameController.dispose();
    phoneNoController.dispose();
    otpCode.dispose();
  }
}
