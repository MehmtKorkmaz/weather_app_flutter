import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherappchallenge/controller/service.dart';
import 'package:weatherappchallenge/controller/shared_manager.dart';
import 'package:weatherappchallenge/views/screens/location_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedManager.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProviderManager>(
        create: (context) => ProviderManager(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0),
        scaffoldBackgroundColor: const Color(0xFF391A49),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
            height: 0,
          ),
          titleSmall: TextStyle(
            color: Color(0xFFEBEBEB),
            fontSize: 10,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 86,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
      home: const Locations(),
    );
  }
}
