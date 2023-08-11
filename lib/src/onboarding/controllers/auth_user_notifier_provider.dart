import 'package:tago/app.dart';
import 'package:tago/src/onboarding/controllers/auth_user_notifier.dart';
import 'package:tago/src/onboarding/controllers/auth_user_state.dart';

final authUserProvider = StateNotifierProvider<AuthUserNotifier, AuthUserState>((ref) {
  // final authImpl = ref.watch(authUserProvider); 
  return AuthUserNotifier();
});

