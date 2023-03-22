import 'package:flutter/material.dart';
import 'package:front/screens/save_screen.dart';
import 'package:front/widgets/bottom_app_bar.dart';

class RouteStep {
  final String time;
  final String location;
  final String transport;

  RouteStep(
      {required this.time, required this.location, required this.transport});
}

class RouteScreen extends StatelessWidget {
  final List<RouteStep> routeSteps = [
    RouteStep(time: '09:00', location: '出発地', transport: '歩く'),
    RouteStep(time: '09:10', location: '地下鉄駅', transport: '地下鉄'),
    RouteStep(time: '09:25', location: '駅前バス停', transport: 'バス'),
    RouteStep(time: '09:50', location: '目的地', transport: '歩く'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Screen'),
      ),
      bottomNavigationBar: const ListScreenBottomBar(
        buttonText: 'Confirm & Save',
        nextPage: SaveScreen(title: 'Save Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: routeSteps.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              minVerticalPadding: 0,
              leading: Text(routeSteps[index].time),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 1,
                        height: 100,
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              border: Border.fromBorderSide(
                                BorderSide(color: Colors.black, width: 2),
                              ),
                              color: Color(0xffffffff),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(routeSteps[index].location),
                        Text(routeSteps[index].transport),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
