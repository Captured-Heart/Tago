import 'package:tago/app.dart';
part 'hive_fulfillment_hub_model.g.dart';

@HiveType(typeId: 2)
class FulfillmentHubModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String address;
  @HiveField(3)
  final double latitude;
  @HiveField(4)
  final double longitude;

  FulfillmentHubModel({
    this.id,
    this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory FulfillmentHubModel.fromJson(Map<String, dynamic> json) {
    return FulfillmentHubModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      };
}
