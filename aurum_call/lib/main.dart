import 'package:aurum_call/pages/map_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AurumCallApp());
}

class AurumCallApp extends StatelessWidget {
  const AurumCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aurum Call",
      home: const MapPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
