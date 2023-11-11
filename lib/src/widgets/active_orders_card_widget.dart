import 'package:tago/app.dart';

Container activeOrdersCard({
  required BuildContext context,
  required int orderStatus,
  required OrderListModel orderModel,
  Function? onViewDetails,
}) {
  var address =
      "${orderModel.address!.apartmentNumber} ${orderModel.address!.streetAddress} \n${orderModel.address!.city}, ${orderModel.address!.state}";

  return Container(
    // height: 250,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.1),
      ),
    ),
    width: double.infinity,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textBaseline: TextBaseline.alphabetic,
      children: [
        cachedNetworkImageWidget(
          imgUrl: orderModel.orderItems!.first.product?.productImages?.first['image']['url'],
          height: 95,
          width: 100,
        ).padOnly(right: 10),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderModel.name ?? '',
              style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: AppFontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(address,
                style:
                    context.theme.textTheme.bodyMedium?.copyWith(fontWeight: AppFontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            onViewDetails != null
                ? GestureDetector(
                    onTap: () {
                      onViewDetails();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: TagoLight.orange.withOpacity(0.1),
                      ),
                      child: Text(
                        TextConstant.viewdetails,
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.bodyLarge?.copyWith(
                          color: TagoLight.orange,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        )),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: getOrderStatusColor(orderStatus).withOpacity(0.1),
          ),
          child: Text(
            getOrderStatusTitle(orderStatus),
            style: context.theme.textTheme.bodyLarge
                ?.copyWith(color: getOrderStatusColor(orderStatus)),
          ),
        ),
      ],
    ),
  );
}
