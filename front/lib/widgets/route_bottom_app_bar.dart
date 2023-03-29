import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/providers/places_provider.dart';
import 'package:front/services/place_api_service.dart';

class RouteScreenBottomBar extends StatefulWidget {
  final String buttonText;
  final Widget nextPage;
  final List? data;

  const RouteScreenBottomBar({
    Key? key,
    required this.buttonText,
    required this.nextPage,
    this.data,
  }) : super(key: key);

  @override
  _RouteScreenBottomBarState createState() => _RouteScreenBottomBarState();
}

class _RouteScreenBottomBarState extends State<RouteScreenBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            SizedBox(
              width: 280,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.nextPage,
                    ),
                  );
                },
                child: Text(widget.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
