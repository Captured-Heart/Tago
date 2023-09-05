
import 'package:tago/app.dart';

class FulfillmentHubModel extends Equatable {
  final String? id;
  final String? name;
  final String? address;
  final String? position;

  const FulfillmentHubModel({
    this.id,
    this.name,
    this.address,
    this.position,
  });

  factory FulfillmentHubModel.fromJson(Map<String, dynamic> json) {
    return FulfillmentHubModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      position: json['position'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'position': position,
      };

  @override
  List<Object?> get props => [id, name, address, position];
}
