import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    StateProvider((ref) => Itinerary(date: '', startTime: '', endTime: ''));

class Itinerary {
  String date;
  String startTime;
  String endTime;

  void updateItinerary(String newDate, String newStartTime, String newEndTime) {
    date = newDate;
    startTime = newStartTime;
    endTime = newEndTime;
  }

  Itinerary(
      {required this.date, required this.startTime, required this.endTime});
}

class ItineraryNotifier extends StateNotifier<Itinerary> {
  ItineraryNotifier() : super(Itinerary(date: '', startTime: '', endTime: ''));

  void updateItinerary(String dateTime, String startTime, String endTime) {
    state.updateItinerary(dateTime, startTime, endTime);
  }
}
