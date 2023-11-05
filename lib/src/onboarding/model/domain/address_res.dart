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
