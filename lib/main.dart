import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wildfire_tracker/provider/dataProvider.dart';
import 'package:wildfire_tracker/views/homeView.dart';

// views
import './views/homeView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WildFire Tracker',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeView(),
      ),
    );
  }
}