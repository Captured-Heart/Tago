import 'package:tago/app.dart';
import 'package:tago/screens/account/add_new_cards.dart';
import 'package:tago/widgets/fruits_veggies_card.dart';

class PaymentsMethodScreen extends ConsumerWidget {
  const PaymentsMethodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.savedCards,
        isLeading: true,
      ),
      body: ListView(
        children: [
          drawerListTile(
            context: context,
            imageLeading: Image.asset(
              mastercardLogo,
              height: 25,
              width: 35,
              fit: BoxFit.fill,
            ),
            icons: FontAwesomeIcons.a,
            iconColor: TagoDark.primaryColor,
            isImageLeading: true,
            materialIconSize: 24,
            isMaterialIcon: true,
            title: 'Ending in 4232',
          ),
          drawerListTile(
            context: context,
            imageLeading: Image.asset(
              visacardLogo,
              height: 25,
              width: 35,
              fit: BoxFit.fill,
            ),
            icons: FontAwesomeIcons.a,
            iconColor: TagoDark.primaryColor,
            isImageLeading: true,
            materialIconSize: 24,
            isMaterialIcon: true,
            title: 'Ending in 4232',
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                push(context, const AddNewCardsScreen());
              },
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline),
              ),
              label: Text(TextConstant.addnewCard),
            ),
          )
        ],
      ),
    );
  }
}
