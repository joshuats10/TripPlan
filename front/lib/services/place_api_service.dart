import 'package:dio/dio.dart';
import 'package:front/models/tourist_attraction.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng> getLocationFromText(String text, String apiKey) async {
  final query = Uri.encodeQueryComponent(text);
  final url =
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=geometry&input=$query&inputtype=textquery&key=$apiKey';

  final response = await Dio().get(url);
  final data = response.data;

  if (data['status'] == 'OK') {
    final result = data['candidates'][0]['geometry']['location'];
    final lat = result['lat'];
    final lng = result['lng'];
    return LatLng(lat, lng);
  } else {
    throw Exception('Failed to get location from address');
  }
}

Future<List<TouristAttraction>> getNearbyPlaces(
    LatLng latlng, String apiKey) async {
  final lat = latlng.latitude;
  final lng = latlng.longitude;
  final url =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=5000&type=tourist_attraction&key=$apiKey';

  final response = await Dio().get(url);
  final data = response.data;

  if (data['status'] == 'OK') {
    final results = data['results'];
    final List<TouristAttraction> places = [];
    for (final result in results) {
      final place = TouristAttraction(
        result['place_id'],
        result['geometry']['location']['lat'],
        result['geometry']['location']['lng'],
        result['name'],
        result['photos'][0]['photo_reference'],
      );
      places.add(place);
    }
    return places;
  } else {
    throw Exception('Failed to get nearby places');
  }
}

Future<void> addPlace(String name) async {
  final dio = Dio();
  final url = 'http://127.0.0.1:8000/api/places/add/';
  final data = {'name': name};

  try {
    final response = await dio.post(url, data: data);
    print(response.data);
  } catch (error) {
    print(error);
  }
}

Future<List<Map<String, dynamic>>> getPlaces() async {
  final dio = Dio();
  final url = 'http://127.0.0.1:8000/api/places/';

  try {
    final Response response = await dio.get(url);
    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(response.data);
    return data;
  } catch (error) {
    print(error);
    throw Exception('Failed to get places');
  }
}
