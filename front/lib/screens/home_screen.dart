import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screens/attraction_list_screen.dart';
import 'package:front/screens/map_screen.dart';
import 'package:front/screens/main_form_screen.dart';
import 'package:front/screens/route_screen.dart';
import 'package:front/widgets/custom_button.dart';

class ButtonData {
  final String title;
  final Widget screen;

  ButtonData({required this.title, required this.screen});
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final List<ButtonData> buttons = [
    ButtonData(title: 'Map Sample', screen: const MapSample()),
    ButtonData(title: 'Main Form Screen', screen: const MainFormScreen()),
    ButtonData(title: 'Route Screen', screen: RouteScreen()),
    ButtonData(
        title: 'Attraction List Screen', screen: const AttractionListScreen())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child:
                  SvgPicture.asset('assets/images/undraw_journey_re_ec5q.svg'),
            ),
            const Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Get your optimal itinerary for your next trip',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  final button = buttons[index];
                  return CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => button.screen,
                        ),
                      );
                    },
                    buttonText: button.title,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
