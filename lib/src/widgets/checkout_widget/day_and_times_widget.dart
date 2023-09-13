import 'package:tago/app.dart';

class CheckOutDayAndTimesWidget extends ConsumerStatefulWidget {
  const CheckOutDayAndTimesWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckOutDayAndTimesWidgetState();
}

class _CheckOutDayAndTimesWidgetState extends ConsumerState<CheckOutDayAndTimesWidget> {
  int? selectedValue;
  int selectedIndex = 0;

  Color getColor(int selectedIndex, int index) {
    if (index == selectedIndex) {
      return TagoLight.primaryColor;
    } else {
      return TagoLight.textFieldBorder;
    }
  }

  @override
  Widget build(BuildContext context) {
    final availabileDate = ref.watch(getAvailabileDateProvider);
    final availabileTimes = ref.watch(getAvailabileTimesProvider(selectedIndex));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                TextConstant.day,
                style: context.theme.textTheme.bodyLarge,
              ),
              availabileDate.when(
                data: (data) {
                  return Row(
                    children: List.generate(
                        data.length,
                        (index) => GestureDetector(
                              onTap: () {
                                log(data[index].times![1].toString());
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: getColor(selectedIndex, index),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      getDayOfWeek(data[index].date!),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: AppTextStyle.hintTextStyleLight.copyWith(
                                        color: context.theme.scaffoldBackgroundColor,
                                        fontWeight: AppFontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      dateFormatted2(data[index].date!),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: AppTextStyle.hintTextStyleLight.copyWith(
                                        color: context.theme.scaffoldBackgroundColor,
                                        fontWeight: AppFontWeight.w700,
                                      ),
                                    ),
                                  ].columnInPadding(5),
                                ),
                              ),
                            )).toList(),
                  );
                },
                error: (err, _) => const Text('No time available'),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            ].columnInPadding(10)),

        //CHOOSE TIME
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextConstant.chhoseTime,
              style: context.theme.textTheme.bodyLarge,
            ),
            availabileTimes.when(
              data: (data) {
                return Column(
                  children: List.generate(
                    data.length,
                    (index) {
                      var timesModel = data[index];
                      return radioListTileWidget(
                        context: context,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                          log(value.toString());
                        },
                        title:
                            '${timesModel.startTime}am to ${convertTo12Hrs(int.tryParse(timesModel.endTime!)!)}pm',
                        isAvailable: timesModel.status!,
                        selectedValue: selectedValue ?? 0,
                        value: index,
                      );
                    },
                  ).toList(),
                );
              },
              error: (error, _) => Text(error.toString()),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ],
        )
      ].columnInPadding(10),
    );
  }
}

// Column checkoutDayAndTimesWidget({
//   required BuildContext context,
//   required AsyncValue<List<AvailabilityModel>> availabileDate,
//   required AsyncValue<List<TimesModel>> availabileTimes,
//   // required VoidCallback onTapDate,
//   required VoidCallback onTapScheduleDelivering,
//   required Function setState,
// }) {
//   int selectedIndex = 0;
//   Color getColor(int selectedIndex, int index) {
//     if (index == selectedIndex) {
//       return TagoLight.primaryColor;
//     } else {
//       return TagoLight.textFieldBorder;
//     }
//   }

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               TextConstant.day,
//               style: context.theme.textTheme.bodyLarge,
//             ),
//             availabileDate.when(
//               data: (data) {
//                 return Row(
//                   children: List.generate(
//                       data.length,
//                       (index) => GestureDetector(
//                             onTap: () {
//                               log(data[index].times![1].toString());
//                               setState(() {
//                                 selectedIndex = index;
//                               });
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(18),
//                               margin: const EdgeInsets.symmetric(horizontal: 5),
//                               decoration: BoxDecoration(
//                                 color: getColor(selectedIndex, index),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     getDayOfWeek(data[index].date!),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 1,
//                                     style: AppTextStyle.hintTextStyleLight.copyWith(
//                                       color: context.theme.scaffoldBackgroundColor,
//                                       fontWeight: AppFontWeight.w700,
//                                     ),
//                                   ),
//                                   Text(
//                                     dateFormatted2(data[index].date!),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 1,
//                                     style: AppTextStyle.hintTextStyleLight.copyWith(
//                                       color: context.theme.scaffoldBackgroundColor,
//                                       fontWeight: AppFontWeight.w700,
//                                     ),
//                                   ),
//                                 ].columnInPadding(5),
//                               ),
//                             ),
//                           )).toList(),
//                 );
//               },
//               error: (err, _) => const Text('No time available'),
//               loading: () => const Center(
//                 child: CircularProgressIndicator.adaptive(),
//               ),
//             )
//           ].columnInPadding(10)),

//       //CHOOSE TIME
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             TextConstant.chhoseTime,
//             style: context.theme.textTheme.bodyLarge,
//           ),
//           availabileTimes.when(
//             data: (data) {
//               return Column(
//                 children: List.generate(
//                   data.length,
//                   (index) {
//                     var timesModel = data[index];
//                     return radioListTileWidget(
//                       onChanged: (value) {
//                         setState(() {
//                           selectedValue = value!;
//                         });
//                         log(value.toString());
//                       },
//                       title:
//                           '${timesModel.startTime}am to ${convertTo12Hrs(int.tryParse(timesModel.endTime!)!)}pm',
//                       isAvailable: timesModel.status!,
//                       selectedValue: selectedValue ?? 0,
//                       value: index,
//                     );
//                   },
//                 ).toList(),
//               );
//             },
//             error: (error, _) => Text(error.toString()),
//             loading: () => const Center(
//               child: CircularProgressIndicator.adaptive(),
//             ),
//           ),
//         ],
//       )
//     ].columnInPadding(10),
//   );
// }
