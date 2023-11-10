import 'package:tago/app.dart';

class FulfillmentHubModel extends Equatable {
  final String? id;
  final String? name;
  final String address;
  final double latitude;
  final double longitude;

  const FulfillmentHubModel(
      {this.id,
      this.name,
      required this.address,
      required this.latitude,
      required this.longitude});

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

  @override
  List<Object?> get props => [id, name, address, latitude, longitude];
}
