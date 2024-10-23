import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/pelanggan_screen.dart';
import 'screens/transaksi_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warnet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/pelanggan': (context) => const PelangganScreen(),
        '/transaksi': (context) => const TransaksiScreen(),
      },
    );
  }
}
