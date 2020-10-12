import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<String> cityNames = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    // getCityNames();
    Navigator.pushReplacementNamed(context, '/home');
  }

  // void getCityNames() async {
  //   hotelService.HotelService service = new hotelService.HotelService();
  //   await service.getCityNames();
  //   this.cityNames = service.cityNames;
  //   Navigator.pushReplacementNamed(context, '/home',
  //       arguments: {'cityNames': cityNames});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // rgb(175, 155, 123)
      backgroundColor: Color.fromRGBO(175, 155, 123, 1.0),
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.lightBlue[900],
          size: 50.0,
        ),
      ),
    );
  }
}
