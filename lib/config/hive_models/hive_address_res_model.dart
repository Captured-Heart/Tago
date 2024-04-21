import 'package:tago/app.dart';
part 'hive_address_res_model.g.dart';

@HiveType(typeId: 6)
class AddressSearchResponse extends HiveObject {
  @HiveField(0)
  final String? placeId;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? city;
  @HiveField(3)
  final String? region;
  @HiveField(4)
  final String? streetAddress;
  @HiveField(5)
  final String? postal;
  @HiveField(6)
  final int? streetNumber;
  @HiveField(7)
  final double? latitude;
  @HiveField(8)
  final double? longitude;
  @HiveField(9)
  final double? elevation;
  @HiveField(10)
  final int? geoNumber;
  @HiveField(11)
  final double? distance;

  AddressSearchResponse({
    this.placeId,
    this.description,
    this.city,
    this.region,
    this.streetAddress,
    this.postal,
    this.streetNumber,
    this.latitude,
    this.longitude,
    this.elevation,
    this.geoNumber,
    this.distance,
  });

  factory AddressSearchResponse.fromJson(Map<String, dynamic> json) => AddressSearchResponse(
        placeId: json['placeId'] as String?,
        description: json['description'] as String?,
        streetNumber: json['streetNumber'] as int?,
        streetAddress: json['streetAddress'] as String?,
        longitude: json['longitude'] as double?,
        latitude: json['latitude'] as double?,
        elevation: json['elevation'] as double?,
        distance: json['distance'] as double?,
        geoNumber: json['geoNumber'] as int?,
        city: json['city'] as String?,
        region: json['region'] as String?,
        postal: json['postal'] as String?,
      );

  // Implement the toJson method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'elevation': elevation,
      'geoNumber': geoNumber,
      'distance': distance,
      'streetAddress': streetAddress,
      'streetNumber': streetNumber,
      'city': city,
      'region': region,
      'postal': postal,
    };
  }
}
