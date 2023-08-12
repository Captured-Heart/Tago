import 'package:tago/app.dart';

final authUserProvider =
    StateNotifierProvider<AuthUserNotifier, AuthUserState>((ref) {
  return AuthUserNotifier();
});
