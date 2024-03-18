import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'dart:async';

class MyLocationApp extends StatefulWidget {
  @override
  _MyLocationAppState createState() => _MyLocationAppState();
}

class _MyLocationAppState extends State<MyLocationApp> {
  String _longitude = "";
  String _latitude = "";

  StreamSubscription<Position>? locationSubscription;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  Future<bool> _requestLocationPermission() async {
    var locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus.isGranted) {
      return true;
    } else {
      // Handle permission denied or permanently denied scenarios
      await Permission.locationWhenInUse.request();
      return false;
    }
  }

  void _startLocationUpdates() async {
    if (await _requestLocationPermission()) {
      locationSubscription = Geolocator.getPositionStream(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high))
          .listen((position) {
        setState(() {
          _longitude = position.longitude.toStringAsFixed(4);
          _latitude = position.latitude.toStringAsFixed(4);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Stream'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Longitude: $_longitude'),
            Text('Latitude: $_latitude'),
            ElevatedButton(
              onPressed: _startLocationUpdates, // Call on button press
              child: Text('Start Capturing Location'),
            ),
          ],
        ),
      ),
    );
  }
}
