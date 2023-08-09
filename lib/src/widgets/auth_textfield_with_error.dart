import 'package:flutter/services.dart';
import 'package:tago/app.dart';

Widget authTextFieldWithError({
  required TextEditingController controller,
  FocusNode? focusNode,
  List<TextInputFormatter>? inputFormatters,
  String? hintText,
  String? errorText,
  Function(String)? onChanged,
  required BuildContext context,
  Widget? suffixIcon,
  bool obscureText = false,
  TextInputType? keyboardType,
  VoidCallback? onTap,
  Widget? prefixIcon,
  required bool isError,
  bool? filled,
  Color? fillColor,
}) {
  return Column(children: [
    TextField(
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      cursorColor: TagoDark.primaryColor,
      inputFormatters: inputFormatters ??
          [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
      decoration: InputDecoration(
        hintText: hintText,
        
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: filled,
        hintStyle: AppTextStyle.hintTextStyleLight,
        suffixIconColor: TagoLight.textFieldBorder,
        prefixIconColor: TagoLight.textFieldBorder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 4,
            color: TagoLight.textFieldBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(width: 1, color: TagoLight.textFieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(width: 1, color: TagoLight.textFieldBorder),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(width: 1, color: TagoLight.textFieldBorder),
        ),
        errorMaxLines: 1,
        // errorStyle: AppTextStyle().errorTextStyle,
      ),
    ).padOnly(bottom: 3),
    isError == true
        ? Container(
            alignment: Alignment.topLeft,
            child: Text(
              errorText ?? '',
              textAlign: TextAlign.start,
              //TODO: CHANGED THEME OF TEXT ERRORS
              style: Theme.of(context).textTheme.labelSmall,
            ),
          )
        : const SizedBox.shrink()
  ]);
}
