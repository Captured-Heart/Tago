import 'package:tago/app.dart';

final riderAcceptDeclineNotifierProvider =
    StateNotifierProvider<RiderAcceptDeclineNotifier, AsyncValue>((ref) {
  return RiderAcceptDeclineNotifier();
});
