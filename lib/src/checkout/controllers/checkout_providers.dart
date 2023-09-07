
import 'package:tago/app.dart';

final getAvailabileDateProvider = FutureProvider.autoDispose<List<AvailabilityModel>>((ref) async {
  return getAvailableTimesMethod();
});
