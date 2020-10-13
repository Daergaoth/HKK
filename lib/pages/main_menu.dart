import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  List<String> options = ['Single Player', 'MultiPlayer', 'Options', 'Exit'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(150.0),
        //   child: AppBar(
        //
        //     backgroundColor: Color.fromRGBO(175, 155, 123, 1.0),
        //     title: Center(
        //       child: Image.network(
        //           'https://lh3.googleusercontent.com/proxy/QYCNzAShgk5K4YSuwJDqvIoNfCeKQcDuzqLLtbCC9PE87AnIZgk7TmNMQUgbYiXCJP73LA'),
        //     ),
        //   ),
        // ),
        backgroundColor: Color.fromRGBO(175, 155, 123, 1.0),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image.asset('assets/hkk_logo.png'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                //         hoverColor: Colors.lime,
                // focusElevation: 50.0,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/singlePlay');
                },
                child: Text(options[0]),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                //         hoverColor: Colors.lime,
                // focusElevation: 50.0,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: null,
                child: Text(options[1]),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                //         hoverColor: Colors.lime,
                // focusElevation: 50.0,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: null,
                child: Text(options[2]),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                //         hoverColor: Colors.lime,
                // focusElevation: 50.0,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: null,
                child: Text(options[3]),
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: options.length,
            //     itemBuilder: (context, index) {
            //       return Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           // Container(
            //           //     child: Padding(
            //           //       padding: const EdgeInsets.all(8.0),
            //           //       child: Text(options[index]),
            //           //     )
            //           // )
            //           Container(
            //             width: MediaQuery.of(context).size.width * 0.8,
            //             child:
            //             RaisedButton(
            //       //         hoverColor: Colors.lime,
            //       // focusElevation: 50.0,
            //               shape: BeveledRectangleBorder(
            //                   borderRadius: BorderRadius.circular(30)),
            //               onPressed: null,
            //               child: Text(options[index]),
            //             ),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
          ],
        ));
  }
}
