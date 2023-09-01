const String requiredValue = 'this is a required field';
const String phoneValidation = 'Please provide a valid phone number';
const String passwordIsNotStrong = 'password is not strong enough';
const String passwordMustBeAtleast = 'password must be at least 8 digits long';
const String passwordMustHaveaSymbol =
    'passwords must have at least one special character';
const String passwordIsRequired = 'password is required';
const String otpisInvalid = 'otp code is invalid';

// const String passwordRegex = '^(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{11,}$';

enum AuthErrors {
  requiredValue('this is a required field'),
  phoneValidation('Please provide a valid phone number'),
  passwordIsNotStrong('password is not strong enough'),
  passwordMustBeAtleast('password must be at least 8 digits long'),
  passwordMustHaveaSymbol('passwords must have at least one special character'),
  passwordIsRequired('password is required'),
  otpisInvalid('otp code is invalid'),
  passwordDoesNotMatch('passwords do not match');

  const AuthErrors(this.errorMessage);
  final String errorMessage;
}
