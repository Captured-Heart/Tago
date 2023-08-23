import 'package:tago/app.dart';

class TextEditingControllerClass {
  final GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInformKey = GlobalKey<FormState>();

  TextEditingController passWordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  // TextEditingController emailController = TextEditingController();
}
