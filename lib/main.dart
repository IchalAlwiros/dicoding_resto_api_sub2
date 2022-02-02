import 'package:dicoding_submission_restoapi/data/api/ApiService.dart';
import 'package:dicoding_submission_restoapi/ui/restaurant_page.dart';
import 'package:dicoding_submission_restoapi/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiService>(
      create: (context) => ApiService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/restaurant': (context) => RestaurantPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
