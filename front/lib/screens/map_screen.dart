import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/constants.dart';
import 'package:front/main.dart';
import 'package:front/providers/places_provider.dart';
import 'package:front/screens/attraction_list_screen.dart';
import 'package:front/services/place_api_service.dart';
import 'package:front/utils/cache.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:front/models/tourist_attraction.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

class MapSample extends StatefulWidget {
  const MapSample(
      {super.key, required this.latlng, required this.touristAttractions});

  final LatLng latlng;
  final List<TouristAttraction> touristAttractions;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController _mapController;
  var _savedPlaces = <String>{};

  final _pageController = PageController(
    viewportFraction: 0.85, //0.85くらいで端っこに別のカードが見えてる感じになる
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Screen'),
        ),
        body: Consumer(builder: (context, ref, child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _mapSection(),
              _cardSection(ref),
              _buttonSection(),
            ],
          );
        }));
  }

  Widget _mapSection() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      initialCameraPosition: CameraPosition(
        target: widget.latlng,
        zoom: 13,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      markers: widget.touristAttractions.map(
        (selectedSpot) {
          return Marker(
            markerId: MarkerId(selectedSpot.id),
            position: LatLng(selectedSpot.latitude, selectedSpot.longitude),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () async {
              //タップしたマーカー(spot)のindexを取得
              final index = widget.touristAttractions
                  .indexWhere((spot) => spot == selectedSpot);
              //タップしたお店がPageViewで表示されるように飛ばす
              _pageController.jumpToPage(index);
            },
          );
        },
      ).toSet(),
    );
  }

  Widget _buttonSection() {
    return Positioned(
      bottom: 266,
      right: 16.0,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AttractionListScreen(),
            ),
          );
        },
        child: Icon(Icons.list),
      ),
    );
  }

  Widget _cardSection(ref) {
    return Stack(
      children: [
        Container(
          height: 250,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: PageView(
            onPageChanged: (int index) async {
              //スワイプ後のページのお店を取得
              final selectedSpot = widget.touristAttractions.elementAt(index);
              //現在のズームレベルを取得
              final zoomLevel = await _mapController.getZoomLevel();
              //スワイプ後のお店の座標までカメラを移動
              _mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target:
                        LatLng(selectedSpot.latitude, selectedSpot.longitude),
                    zoom: zoomLevel,
                  ),
                ),
              );
            },
            controller: _pageController,
            children: _spotTiles(ref),
          ),
        ),
      ],
    );
  }

  List<Widget> _spotTiles(ref) {
    final _spotTiles = widget.touristAttractions.map((spot) {
      final alreadySaved = _savedPlaces.contains(spot.id);
      return Card(
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${spot.photo}&key=$apiKey',
                cacheManager: customCacheManager,
                placeholder: (context, url) => Image.memory(kTransparentImage),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                        minHeight: 68.0, maxHeight: 68.0 // 最小の高さを指定
                        ),
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                spot.name,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Spacer(),
                          Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    Place place = Place(
                                        place_id: spot.id,
                                        place_name: spot.name,
                                        photo_reference: spot.photo);
                                    if (alreadySaved) {
                                      ref
                                          .read(placesNotifierProvider)
                                          .deletePlace(place);
                                      _savedPlaces.remove(spot.id);
                                    } else {
                                      ref
                                          .read(placesNotifierProvider)
                                          .addPlace(place);
                                      _savedPlaces.add(spot.id);
                                    }
                                  });
                                },
                                shape: CircleBorder(),
                                child: Icon(
                                    alreadySaved ? Icons.delete : Icons.add),
                                color: Colors.orange,
                                textColor: Colors.white,
                              ))
                        ]))))

            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //         spot.name,
            //         style: TextStyle(
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 10,
            //   right: 10,
            //   child: InkWell(
            //     onTap: () {
            //       var placesRef = ref.read(placesNotifierProvider);
            //       Place place = Place(
            //           place_id: spot.id,
            //           place_name: spot.name,
            //           photo_reference: spot.photo);
            //       final alreadySaved = _savedPlaces.contains(place);
            //       setState(() {
            //         alreadySaved
            //             ? placesRef.deletePlace(place)
            //             : placesRef.addPlace(place);
            //       });
            //     },
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       decoration: BoxDecoration(
            //         color: Colors.orange,
            //         shape: BoxShape.circle,
            //       ),
            //       child: Icon(alreadySaved ? Icons.delete : Icons.add),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }).toList();
    return _spotTiles;
  }
}
