
  import '../app.dart';

Widget categoryCard({
    required BuildContext context,
    required int index,
  }) {
    return SizedBox(
      width: context.sizeWidth(0.16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            categoriesFrame[index],
            height: 70,
            width: 100,
            fit: BoxFit.fill,
          ).padOnly(bottom: 4),
          Text(
            categoriesFooters[index],
            textAlign: TextAlign.center,
            style: context.theme.textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              fontFamily: TextConstant.fontFamilyBold,
            ),
          )
        ],
      ),
    );
  }