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
            availabileDate.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(child: Text(TextConstant.scheduleLaterNotAvailable));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //CHOOSE DAY
                    Text(
                      TextConstant.day,
                      style: context.theme.textTheme.bodyLarge,
                    ),
                    Row(
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
                        ),
                      ).toList(),
                    ),

                    //
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
                          error: (error, _) =>
                              const Center(child: Text('No available time, at the moment'))
                                  .padOnly(top: 10),
                          loading: () => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              error: (err, _) => const Text('No day is available'),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          ].columnInPadding(10),
        ),

        //   //CHOOSE TIME

        //  Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               TextConstant.chhoseTime,
        //               style: context.theme.textTheme.bodyLarge,
        //             ),
        //             availabileTimes.when(
        //               data: (data) {
        //                 return Column(
        //                   children: List.generate(
        //                     data.length,
        //                     (index) {
        //                       var timesModel = data[index];
        //                       return radioListTileWidget(
        //                         context: context,
        //                         onChanged: (value) {
        //                           setState(() {
        //                             selectedValue = value!;
        //                           });
        //                           log(value.toString());
        //                         },
        //                         title:
        //                             '${timesModel.startTime}am to ${convertTo12Hrs(int.tryParse(timesModel.endTime!)!)}pm',
        //                         isAvailable: timesModel.status!,
        //                         selectedValue: selectedValue ?? 0,
        //                         value: index,
        //                       );
        //                     },
        //                   ).toList(),
        //                 );
        //               },
        //               error: (error, _) =>
        //                   const Center(child: Text('No available time, at the moment'))
        //                       .padOnly(top: 10),
        //               loading: () => const Center(
        //                 child: CircularProgressIndicator.adaptive(),
        //               ),
        //             ),
        //           ],
        //         )
      ].columnInPadding(10),
    );
  }
}
