
/*------------------------------------------------------------------
               CATEGORY INDEX PROVIDER
 -------------------------------------------------------------------*/
import 'package:tago/app.dart';

final categoryIndexProvider = StateProvider<int>((ref) {
  return 0;
}, name: 'CATEGORY INDEX PROVIDER');

/*------------------------------------------------------------------
               CATEGORY LABEL PROVIDER
 -------------------------------------------------------------------*/
final categoryLabelProvider = StateProvider<String>((ref) {
  return '';
});
