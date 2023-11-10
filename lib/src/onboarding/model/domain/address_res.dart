class AddressSearchResponse {
  final String? placeId;
  final String? description;
  final String? city;
  final String? region;
  final String? streetAddress;
  final String? postal;
  final int? streetNumber;
  final double? latitude;
  final double? longitude;
  final double? elevation;
  final int? geoNumber;
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

  factory AddressSearchResponse.fromJson(Map<String, dynamic> json) =>
      AddressSearchResponse(
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
