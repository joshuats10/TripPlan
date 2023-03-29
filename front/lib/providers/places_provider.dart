import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placesProvider = StateProvider(
    (ref) => Place(place_id: '', place_name: '', photo_reference: ''));

class Place {
  String place_id;
  String place_name;
  String photo_reference;

  Place(
      {required this.place_id,
      required this.place_name,
      required this.photo_reference});
}

class Places {
  List<Place> places = [];

  void addPlace(Place place) {
    places.add(place);
  }

  void deletePlace(Place place) {
    places.removeWhere((element) => element.place_id == place.place_id);
  }
}

class PlacesNotifier extends StateNotifier<Places> {
  PlacesNotifier() : super(Places());

  void addPlace(Place place) {
    state.addPlace(place);
  }

  void deletePlace(Place place) {
    state.deletePlace(place);
  }
}
