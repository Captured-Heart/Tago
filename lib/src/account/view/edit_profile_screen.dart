import 'package:tago/app.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.accountModel,
  });
  final AccountModel? accountModel;
  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();

  final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: requiredValue),
    ],
  );

  final List<String> genderList = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    var date = ref.watch(dateTimeProvider);

    return FullScreenLoader(
      isLoading: ref.watch(accountAddressProvider).isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          isLeading: true,
          title: TextConstant.editProfile,
        ),
        body: Form(
          key: controller.signUpformKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  TextConstant.editProfile,
                ),
                subtitle: Text(TextConstant.updateYourProfile),
              ),

              //first name
              authTextFieldWithError(
                // controller: controller.firstNameController,
                context: context,
                isError: false,
                label: TextConstant.firstName,
                keyboardType: TextInputType.name,
                validator: passwordValidator,
                initialValue: widget.accountModel?.fname,
                onChanged: (value) {
                  setState(() {
                    controller.firstNameController.text = value;
                  });
                },
              ),

              //last name
              authTextFieldWithError(
                // controller: controller.lastNameController,
                context: context,
                isError: false,
                label: TextConstant.lastName.toTitleCase(),
                keyboardType: TextInputType.name,
                validator: passwordValidator,
                initialValue: widget.accountModel?.lname,
                onChanged: (value) {
                  setState(() {
                    controller.lastNameController.text = value;
                  });
                },
              ),

              //email address
              authTextFieldWithError(
                // controller: controller.emailController,
                context: context,
                isError: false,
                label: TextConstant.emailAddress.toTitleCase(),
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.accountModel?.email,
                validator: MultiValidator(
                  [
                    RequiredValidator(
                      errorText: AuthErrors.requiredValue.errorMessage,
                    ),
                    EmailValidator(
                      errorText: AuthErrors.emailValidation.errorMessage,
                    ),
                  ],
                ),
                onChanged: (value) {
                  setState(() {
                    controller.emailController.text = value;
                  });
                },
              ),

              //gender selection
              CustomDropdown<String>(
                // ignore: prefer_null_aware_operators
                initialItem: widget.accountModel?.gender == null
                    ? null
                    : widget.accountModel?.gender?.toTitleCase(),
                errorStyle: AppTextStyle.errorTextTextstyle,
                hintBuilder: (context, hint) {
                  return Text(
                    TextConstant.gender.toTitleCase(),
                    style: context.theme.textTheme.labelMedium
                        ?.copyWith(fontWeight: AppFontWeight.w300),
                  );
                },
                listItemBuilder: (context, item) {
                  return Text(
                    item,
                    style: context.theme.textTheme.labelMedium
                        ?.copyWith(fontWeight: AppFontWeight.w300),
                  );
                },
                headerBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem,
                    style: context.theme.textTheme.labelMedium
                        ?.copyWith(fontWeight: AppFontWeight.w300),
                  );
                },
                items: genderList,
                onChanged: (value) {
                  setState(() {
                    controller.genderController.text = value;
                  });
                },
                closedBorder: Border.all(width: 0.1),
                validator: (p0) {
                  if (p0 == null) {
                    return AuthErrors.requiredValue.errorMessage;
                  } else {
                    return null;
                  }
                },
                validateOnChange: true,
              ),

              // phone number
              authTextFieldWithError(
                // controller: controller.phoneNoController,
                context: context,
                isError: false,
                label: TextConstant.phoneno.toTitleCase(),
                keyboardType: TextInputType.phone,
                initialValue: widget.accountModel?.phoneNumber,
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: requiredValue),
                    PatternValidator(
                      r'^[0-9\-\+]{9,15}$',
                      errorText: AuthErrors.phoneValidation.errorMessage,
                    ),
                  ],
                ),
                onChanged: (value) {
                  setState(() {
                    controller.phoneNoController.text = value;
                  });
                },
              ),

              //date of birth
              authTextFieldWithError(
                controller: controller.dobController.text.isEmpty ? null : controller.dobController,
                context: context,
                showCursor: false,
                isError: false,
                label: TextConstant.dateOfBirth.toTitleCase(),
                keyboardType: TextInputType.phone,
                initialValue: widget.accountModel?.dob == null
                    ? null
                    : dateFormattedWithYYYY(widget.accountModel!.dob!),
                onChanged: (p0) {
                  setState(() {
                    controller.dobController.text = p0;
                  });
                },
                validator: passwordValidator,
                onTap: () {
                  datePicker(
                    context: context,
                    setState: setState,
                    textController: controller,
                    ref: ref,
                  );
                },
              ),

              //submit button
              SizedBox(
                width: context.sizeWidth(1),
                child: ElevatedButton(
                  onPressed: () {
                    var map = {
                      AuthTypeField.fname.name: controller.firstNameController.text.isEmpty
                          ? widget.accountModel?.fname
                          : controller.firstNameController.text,
                      AuthTypeField.lname.name: controller.lastNameController.text.isEmpty
                          ? widget.accountModel?.lname
                          : controller.lastNameController.text,
                      AuthTypeField.email.name: controller.emailController.text.isEmpty
                          ? widget.accountModel?.email
                          : controller.emailController.text,
                      AuthTypeField.phone.name: controller.phoneNoController.text.isEmpty
                          ? widget.accountModel?.phoneNumber
                          : controller.phoneNoController.text,
                      AuthTypeField.gender.name: controller.genderController.text.isEmpty
                          ? widget.accountModel?.gender
                          : controller.genderController.text,
                      AuthTypeField.dob.name: controller.dobController.text.isEmpty
                          ? widget.accountModel?.dob
                          : date.toIso8601String(),
                      AuthTypeField.id.name: widget.accountModel?.id,
                    };

                    inspect(map);
                    log(map.toString());
                    if (controller.signUpformKey.currentState!.validate()) {
                      ref.read(accountAddressProvider.notifier).editProfileMethod(
                            map: map,
                            context: context,
                            ref: ref,
                          );
                    }
                  },
                  child: const Text(TextConstant.submit),
                ),
              ),
            ].columnInPadding(10),
          ).padSymmetric(horizontal: context.sizeWidth(0.04)),
        ),
      ),
    );
  }
}
