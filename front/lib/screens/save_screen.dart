import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screens/home_screen.dart';
import 'package:front/widgets/custom_button.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key, required this.title});

  final String title;

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
              flex: 2,
              child: SvgPicture.asset(
                  'assets/images/undraw_departing_re_mlq3.svg'),
            ),
            const Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Your itinerary has been saved! Enjoy your trip!',
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
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 48,
                  width: 160,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'Home'),
                        ),
                      );
                    },
                    buttonText: 'Done!',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
