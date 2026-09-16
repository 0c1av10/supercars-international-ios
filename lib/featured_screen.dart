import 'package:flutter/material.dart';

import 'models.dart';
import 'vehicle_detail_screen.dart';

class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = Catalog.vehicles.where((v) => v.featured).firstOrNull;
    if (featured == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Destacado')),
        body: const Center(child: Text('Sin vehículo destacado')),
      );
    }
    return VehicleDetailScreen(vehicle: featured, badge: 'VEHÍCULO DEL MES');
  }
}
