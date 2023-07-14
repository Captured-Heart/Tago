import 'package:tago/app.dart';

class OnBoardScreen extends StatelessWidget {
  static const String routeName = 'Onboard';
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                onBoardBG,
              ),
            ),
          ),
        ),
        SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: context.sizeHeight(0.08),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    child: Image.asset(
                      logoMedium,
                      height: 37,
                      width: 37,
                    ),
                  ).padOnly(right: 10),
                  Text(
                    TextConstant.title.toLowerCase(),
                    style: const TextStyle(
                      fontFamily: TextConstant.fontFamily,
                      color: Colors.white,
                      fontWeight: AppFontWeight.w700,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '''
Delivery
in minutes,
right to you''',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: AppFontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ).padOnly(bottom: 30),

                  
                  SizedBox(
                    width: context.sizeWidth(1),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        TextConstant.createAcct,
                        style: TextStyle(
                          fontWeight: AppFontWeight.w700,
                          fontSize: 16,
                          fontFamily: TextConstant.fontFamily,
                        ),
                      ),
                    ),
                  ).padOnly(bottom: 10),
                  SizedBox(
                    width: context.sizeWidth(1),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: context.theme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                        fixedSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        TextConstant.signIn,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: AppFontWeight.w700,
                          fontSize: 16,
                          fontFamily: TextConstant.fontFamily,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
