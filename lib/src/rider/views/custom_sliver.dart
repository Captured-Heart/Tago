import 'package:tago/app.dart';

class CustomSliverScreen extends ConsumerWidget {
  const CustomSliverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPosition = ref.watch(getCurrentLocationProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                // SliverAppBar is a flexible app bar that can expand and contract
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: context.sizeHeight(0.4), // Set the height when expanded
                  floating: false, // The app bar won't float as the user scrolls
                  pinned: true, // The app bar is pinned to the top
                  flexibleSpace: Column(
                    children: [
                      appBarWidget(
                        context: context,
                        title: TextConstant.newDeliveryRequests,
                        centerTitle: false,
                        isLeading: true,
                      ),
                      Expanded(
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              currentPosition.value?.latitude ?? 20,
                              currentPosition.value?.longitude ?? 12.2,
                            ),
                          ),
                        ).debugBorder(),
                      ),
                    ],
                  ),
                ),
          
          
                // SliverList is a scrollable list within the CustomScrollView
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    },
                    childCount: 50, // Number of items in the list
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              
              SizedBox(
                width: context.sizeWidth(0.9),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(TextConstant.acceptRequest),
                ),
              ),
              SizedBox(
                width: context.sizeWidth(0.9),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: TagoLight.textError.withOpacity(0.8),
                    backgroundColor: TagoLight.textError.withOpacity(0.1),
                  ),
                  child: const Text(TextConstant.saveandContinue),
                ),
              ),
            ].columnInPadding(10),
          ).padOnly(bottom: 30, top: 5)
        ],
      ),
    );
  }
}
