import '../../app.dart';

AppBar appBarWidget({
  required BuildContext context,
  bool? isLeading,
  bool? hasDrawer,
  Widget? suffixIcon,
  bool? centerTitle,
  required String title,
}) {
  return AppBar(
    elevation: 0,
    centerTitle: centerTitle ?? true,
    leading: isLeading != null
        ? hasDrawer == null
            ? IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: TagoLight.textBold,
              )
            : Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                  ),
                );
              })
        : const SizedBox.shrink(),
    title: Text(
      title,
      style: AppTextStyle.appBarTextStyleLight,
    ),
    actions: [suffixIcon ?? const SizedBox.shrink()],
  );
}
