import 'package:tago/app.dart';

enum OrderStatus {
  pending(0, TextConstant.pending),
  received(4, TextConstant.received),
  processing(6, TextConstant.processing),
  delivered(9, TextConstant.delivered),
  cancelled(2, TextConstant.cancelled),
  successful(9, TextConstant.successful),
  pickedUp(7, TextConstant.pickedUp),
  placed(1, TextConstant.placed);

  const OrderStatus(this.status, this.message);
  final int status;
  final String message;
}

getOrderStatusColor(int status) {
  if (status == OrderStatus.cancelled.status) {
    return TagoLight.textError;
  } else if (status == OrderStatus.pending.status) {
    return TagoLight.orange;
  } else {
    return TagoLight.primaryColor;
  }
}

getOrderStatusTitle(int status) {
  if (status == OrderStatus.cancelled.status) {
    return OrderStatus.cancelled.message;
  } else if (status == OrderStatus.pending.status) {
    return OrderStatus.pending.message;
  } else if (status == OrderStatus.delivered.status) {
    return OrderStatus.delivered.message;
  } else if (status == OrderStatus.placed.status) {
    return OrderStatus.placed.message;
  } else if (status == OrderStatus.received.status) {
    return OrderStatus.received.message;
  } else if (status == OrderStatus.pickedUp.status) {
    return OrderStatus.pickedUp.message;
  } else if (status == OrderStatus.successful.status) {
    return OrderStatus.successful.message;
  } else {
    return OrderStatus.processing.message;
  }
}
