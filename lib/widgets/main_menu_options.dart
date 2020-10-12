import 'package:flutter/material.dart';

class MainMenuOptions extends StatefulWidget {
  @override
  _MainMenuOptionsState createState() => _MainMenuOptionsState();
}

class _MainMenuOptionsState extends State<MainMenuOptions> {
  List<String> options = ['Single Player', 'MultiPlayer', 'Options', 'Exit'];

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // backgroundColor: Color.fromRGBO(175, 155, 123, 1.0),
        // body:
        ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(options[index]),
            //     )
            // )
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: null,
                  child: Text('sajt')),
            ),
          ],
        );
      },
    );
    // );
  }
}
