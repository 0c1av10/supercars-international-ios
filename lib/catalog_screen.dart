import 'package:flutter/material.dart';

import 'models.dart';
import 'theme.dart';
import 'vehicle_detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _brand = 'Todos';
  VehicleCondition? _condition;

  List<Vehicle> get _filtered => Catalog.vehicles
      .where((v) =>
          (_brand == 'Todos' || v.brand == _brand) &&
          (_condition == null || v.condition == _condition))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/images/logo.png', height: 34),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'CHINA → VENEZUELA · IMPORTACIÓN MUNDIAL',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.heroGold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Vehículos 0KM y usados directo de los mejores dealers en China.',
            style: TextStyle(color: AppTheme.mid, fontSize: 13),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final b in Catalog.brands)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _Chip(
                      label: b,
                      selected: _brand == b,
                      onTap: () => setState(() => _brand = b),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _Chip(
                label: 'Todos',
                selected: _condition == null,
                onTap: () => setState(() => _condition = null),
              ),
              const SizedBox(width: 8),
              for (final c in VehicleCondition.values)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _Chip(
                    label: c.label,
                    selected: _condition == c,
                    onTap: () => setState(() => _condition = c),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            itemCount: _filtered.length,
            itemBuilder: (context, i) => _VehicleCard(vehicle: _filtered[i]),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppTheme.ink : AppTheme.warm,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppTheme.ink : AppTheme.rule),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppTheme.mid,
          ),
        ),
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => VehicleDetailScreen(vehicle: vehicle)),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.paper,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.rule),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 72,
                    width: double.infinity,
                    child: vehicle.images.isNotEmpty
                        ? Image.asset(vehicle.images.first, fit: BoxFit.cover)
                        : Container(
                            color: AppTheme.warm,
                            child: const Center(
                              child: Icon(Icons.directions_car,
                                  size: 34, color: AppTheme.silver),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.ink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      vehicle.condition.label,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              vehicle.model,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppTheme.ink,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${vehicle.brand} · ${vehicle.year}',
              style: const TextStyle(color: AppTheme.silver, fontSize: 11),
            ),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: vehicle.landedPrice,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.heroGold,
                      fontSize: 12,
                    ),
                  ),
                  const TextSpan(
                    text: ' puesto en destino',
                    style: TextStyle(color: AppTheme.silver, fontSize: 10),
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
