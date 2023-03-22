import 'package:flutter/material.dart';
import 'package:front/screens/attraction_list_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:front/models/tourist_attraction.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController _mapController;

  final _pageController = PageController(
    viewportFraction: 0.85, //0.85くらいで端っこに別のカードが見えてる感じになる
  );

  //初期位置を札幌駅に設定してます
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(43.0686606, 141.3485613),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _mapSection(),
        _cardSection(),
        _buttonSection(),
      ],
    );
  }

  Widget _mapSection() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      markers: tourist_attractions.map(
        (selectedShop) {
          return Marker(
            markerId: MarkerId(selectedShop.uid),
            position: LatLng(selectedShop.latitude, selectedShop.longitude),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () async {
              //タップしたマーカー(shop)のindexを取得
              final index = tourist_attractions
                  .indexWhere((shop) => shop == selectedShop);
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
      bottom: 164,
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

  Widget _cardSection() {
    return Stack(
      children: [
        Container(
          height: 148,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: PageView(
            onPageChanged: (int index) async {
              //スワイプ後のページのお店を取得
              final selectedShop = tourist_attractions.elementAt(index);
              //現在のズームレベルを取得
              final zoomLevel = await _mapController.getZoomLevel();
              //スワイプ後のお店の座標までカメラを移動
              _mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target:
                        LatLng(selectedShop.latitude, selectedShop.longitude),
                    zoom: zoomLevel,
                  ),
                ),
              );
            },
            controller: _pageController,
            children: _shopTiles(),
          ),
        ),
      ],
    );
  }

  List<Widget> _shopTiles() {
    final _shopTiles = tourist_attractions.map((shop) {
      return Card(
        child: Stack(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: Text(shop.name),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  // TODO: Add onPressed action
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
    return _shopTiles;
  }
}
