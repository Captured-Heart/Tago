import '../app.dart';

AppBar appBarWidget({
  required BuildContext context,
  bool? isLeading,
  Widget? suffixIcon,
  required String title,
}) {
  return AppBar(
    elevation: 0,
    leading: isLeading != null
        ? IconButton(
            onPressed: () {
              pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: TagoLight.textBold,
          )
        : const SizedBox.shrink(),
    title: Text(
      title,
      style: AppTextStyle.appBarTextStyleLight,
    ),
    actions: [suffixIcon ?? const SizedBox.shrink()],
  );
}
