import 'package:tago/app.dart';

class VoucherModel extends Equatable {
  final String? code;
  final String? currency;
  final int? amount;

  const VoucherModel({this.code, this.currency, this.amount});

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        code: json['code'] as String?,
        currency: json['currency'] as String?,
        amount: json['amount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'currency': currency,
        'amount': amount,
      };

  @override
  List<Object?> get props => [code, currency, amount];
}
