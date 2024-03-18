import 'package:flutter/material.dart';
import 'package:myapp/my_location_app.dart'; 
// Import your app class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Stream',
      home: MyLocationApp(),
    );
  }
}
