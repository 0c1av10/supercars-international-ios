import 'package:flutter/material.dart';

import 'about_screen.dart';
import 'catalog_screen.dart';
import 'featured_screen.dart';
import 'quote_screen.dart';
import 'splash_screen.dart';
import 'theme.dart';

void main() {
  runApp(const SuperCarsApp());
}

class SuperCarsApp extends StatelessWidget {
  const SuperCarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Cars International',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  static const _tabs = [
    CatalogScreen(),
    FeaturedScreen(),
    QuoteScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.directions_car), label: 'Catálogo'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Del Mes'),
          NavigationDestination(icon: Icon(Icons.description), label: 'Cotizar'),
          NavigationDestination(icon: Icon(Icons.public), label: 'Nosotros'),
        ],
      ),
    );
  }
}
