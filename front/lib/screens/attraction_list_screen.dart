import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front/main.dart';
import 'package:front/screens/route_screen.dart';
import 'package:front/services/place_api_service.dart';
import 'package:front/utils/cache.dart';
import 'package:transparent_image/transparent_image.dart';

class AttractionListScreen extends StatelessWidget {
  const AttractionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final date = ref.read(itineraryNotifierProvider).date;
      final startTime = ref.read(itineraryNotifierProvider).startTime;
      final endTime = ref.read(itineraryNotifierProvider).endTime;
      final places = ref.read(placesNotifierProvider).places;
      return Scaffold(
          appBar: AppBar(
            title: const Text('Attraction List Screen'),
          ),
          floatingActionButton: FloatingActionButton.extended(
              elevation: 4.0,
              icon: const Icon(Icons.send),
              label: const Text('Get Optimal Trip Plan'),
              onPressed: () async {
                final result =
                    await optimizePlan(date, startTime, endTime, places);
                print(result);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RouteScreen(tripId: result),
                  ),
                );
              }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            elevation: 2.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                )
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${places[index].photo_reference}&key=$apiKey',
                          cacheManager: customCacheManager,
                          placeholder: (context, url) =>
                              Image.memory(kTransparentImage),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          places[index].place_name.toString(),
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ));
    });
  }
}
