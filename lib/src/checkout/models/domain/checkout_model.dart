import 'package:equatable/equatable.dart';

class CheckoutModel extends Equatable {
  final String? addressId;
  final String? deliveryType;
  final String? paymentMethod;
  final String? instructions;
  final String? voucherCode;
  final String? scheduleForDate;
  final String? scheduleForTime;
  final String? items;

  const CheckoutModel({
    this.addressId,
    this.deliveryType,
    this.paymentMethod,
    this.instructions,
    this.voucherCode,
    this.scheduleForDate,
    this.scheduleForTime,
    this.items,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
        addressId: json['addressId'] as String?,
        deliveryType: json['deliveryType'] as String?,
        paymentMethod: json['paymentMethod'] as String?,
        instructions: json['instructions'] as String?,
        voucherCode: json['voucherCode'] as String?,
        scheduleForDate: json['scheduleForDate'] as String?,
        scheduleForTime: json['scheduleForTime'] as String?,
        items: json['items'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'addressId': addressId,
        'deliveryType': deliveryType,
        'paymentMethod': paymentMethod,
        'instructions': instructions,
        'voucherCode': voucherCode,
        'scheduleForDate': scheduleForDate,
        'scheduleForTime': scheduleForTime,
        'items': items,
      };

  @override
  List<Object?> get props {
    return [
      addressId,
      deliveryType,
      paymentMethod,
      instructions,
      voucherCode,
      scheduleForDate,
      scheduleForTime,
      items,
    ];
  }
}
