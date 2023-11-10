import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocode/geocode.dart';
import 'package:tago/app.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tago/src/onboarding/model/domain/address_res.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');  //A5NTMWNQ
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    //TODO: NOTIFY USER THAT THEY CAN'T RUN THIS APP WITHOUT NOTIFICATIONS
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

// Geolocator
  final currentPosition = await Geolocator.getCurrentPosition();

  return currentPosition;
}

final getCurrentLocationProvider = FutureProvider.autoDispose<Position>((ref) async {
  final position = await _determinePosition();
  return position;
});

final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleAPIKey);
GeoCode geoCode = GeoCode(apiKey: "529365739930510358181x96248");

Future<Prediction> openGooglePlacesSearch(
    BuildContext context, String? searchText) async {
  Prediction? p = await PlacesAutocomplete.show(
    context: context,
    startText: searchText!,
    apiKey: googleAPIKey,
    radius: 10000000,
    types: [],
    strictbounds: false,
    mode: Mode.fullscreen,
    language: "en",
    decoration: InputDecoration(
      hintText: 'Search',
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    components: [
      Component(Component.country, "ng"),
    ],
  );

  return p!;
}

Future<AddressSearchResponse> getAddress(Prediction p) async {
  PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
  double lat = detail.result.geometry!.location.lat;
  double lng = detail.result.geometry!.location.lng;
  var address = await geoCode.reverseGeocoding(latitude: lat, longitude: lng);
  inspect(address);

  var addressRes = AddressSearchResponse(
      placeId: p.placeId,
      description: p.description,
      city: address.city,
      region: address.region,
      streetAddress: address.streetAddress,
      postal: address.postal,
      streetNumber: address.streetNumber,
      latitude: lat,
      longitude: lng,
      elevation: address.elevation,
      distance: address.distance,
      geoNumber: address.geoNumber);

  return addressRes;
}

Future<Address> getCurrentLocationAddress(double lat, double lng) async {
  var address = await geoCode.reverseGeocoding(latitude: lat, longitude: lng);
  return address;
}

Future<void> saveCurrentLocation(Position position) async {
  await NetworkHelper.postRequestWithToken(
    api: saveCurrentLocationUrl,
    map: {
      "latitude": position.latitude.toString(),
      "longitude": position.longitude.toString()
    },
  );
}
