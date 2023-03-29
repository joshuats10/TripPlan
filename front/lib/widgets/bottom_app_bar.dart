import 'package:flutter/material.dart';

class ListScreenBottomBar extends StatefulWidget {
  final String buttonText;
  final Widget nextPage;

  const ListScreenBottomBar({
    Key? key,
    required this.buttonText,
    required this.nextPage,
  }) : super(key: key);

  @override
  _ListScreenBottomBarState createState() => _ListScreenBottomBarState();
}

class _ListScreenBottomBarState extends State<ListScreenBottomBar> {
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
