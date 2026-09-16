import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';
import 'quote_screen.dart';
import 'theme.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key, required this.vehicle, this.badge});

  final Vehicle vehicle;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vehicle.model)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (badge != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.star, color: AppTheme.heroGold, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    badge!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.heroGold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          _Hero(vehicle: vehicle),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '${vehicle.brand} ${vehicle.year}',
                style: const TextStyle(color: AppTheme.silver),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppTheme.ink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  vehicle.condition.label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            vehicle.model,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppTheme.ink,
            ),
          ),
          const Text(
            'Importado desde China · Inspección documentada · Entrega ~90 días',
            style: TextStyle(color: AppTheme.silver, fontSize: 12),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.6,
            children: [
              _SpecCell(icon: Icons.settings, title: 'Motor', value: vehicle.engine),
              _SpecCell(icon: Icons.tune, title: 'Transmisión', value: vehicle.transmission),
              _SpecCell(icon: Icons.speed, title: 'Potencia', value: vehicle.horsepower),
              _SpecCell(icon: Icons.local_gas_station, title: 'Autonomía', value: vehicle.fuelEconomy),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Equipamiento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.ink)),
          const SizedBox(height: 8),
          for (final h in vehicle.highlights)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppTheme.heroGold, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(h, style: const TextStyle(color: AppTheme.mid, fontSize: 13)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.paper,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.rule),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Precio',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.ink)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Vehículo en origen',
                            style: TextStyle(color: AppTheme.silver, fontSize: 11)),
                        Text(vehicle.vehiclePrice,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.ink)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Total aprox. en destino',
                            style: TextStyle(color: AppTheme.silver, fontSize: 11)),
                        Text(vehicle.landedPrice,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.heroGold)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.ink,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => QuoteScreen(vehicle: vehicle)),
            ),
            icon: const Icon(Icons.description),
            label: const Text('Cotizar este vehículo'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.heroGold,
              side: const BorderSide(color: AppTheme.heroGold),
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () => launchUrl(
              Uri.parse('https://wa.me/${Catalog.whatsappNumber}'),
              mode: LaunchMode.externalApplication,
            ),
            icon: const Icon(Icons.message),
            label: const Text('WhatsApp directo'),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatefulWidget {
  const _Hero({required this.vehicle});

  final Vehicle vehicle;

  @override
  State<_Hero> createState() => _HeroState();
}

class _HeroState extends State<_Hero> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.vehicle.images;
    if (images.isEmpty) {
      return Container(
        height: 150,
        decoration: BoxDecoration(
          color: AppTheme.warm,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(Icons.directions_car, size: 64, color: AppTheme.silver),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: images.length,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (_, i) => Image.asset(images[i], fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < images.length; i++)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _page ? Colors.white : Colors.white54,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecCell extends StatelessWidget {
  const _SpecCell({required this.icon, required this.title, required this.value});

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.warm,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: AppTheme.heroGold),
              const SizedBox(width: 5),
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 11, color: AppTheme.heroGold)),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(value,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.ink)),
        ],
      ),
    );
  }
}
