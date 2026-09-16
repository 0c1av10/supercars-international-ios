import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';
import 'theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nosotros')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              height: 110,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Exportación directa de vehículos 0KM desde China hacia Venezuela y el mundo. '
            'Proceso transparente, 90 días, precio de origen.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          const Text('Nuestra historia',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text(
            '"Creemos que todos merecen acceso a un vehículo de calidad, importado '
            'directamente desde origen, con transparencia total en cada paso."',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 8),
          const Text(
            'Super Cars International nació para eliminar intermediarios y acercar los '
            'mejores vehículos del mundo — especialmente desde China a Venezuela y Latinoamérica.',
            style: TextStyle(color: Colors.white60, fontSize: 13),
          ),
          const SizedBox(height: 24),
          const Text('Por qué nosotros',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const _FeatureRow(
            number: '01',
            title: 'Seguridad total',
            text: 'Contratos en regla, pagos estructurados por etapas y documentación '
                'completa. Tu inversión siempre protegida.',
          ),
          const _FeatureRow(
            number: '02',
            title: 'Comunicación en vivo',
            text: 'Fotos y videos en tiempo real desde China. Seguimiento del barco. '
                'Nunca estás sin información de tu auto.',
          ),
          const _FeatureRow(
            number: '03',
            title: 'Calidad certificada',
            text: 'Todos los vehículos son 0KM, inspeccionados en origen con '
                'documentación oficial de fábrica.',
          ),
          const SizedBox(height: 24),
          const Text('Cobertura', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('China → el mundo',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final d in Catalog.destinations)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.card,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(d, style: const TextStyle(fontSize: 12)),
                ),
            ],
          ),
          const SizedBox(height: 28),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.brand,
              side: const BorderSide(color: AppTheme.brand),
              minimumSize: const Size.fromHeight(44),
            ),
            onPressed: () => launchUrl(Uri.parse(Catalog.siteUrl),
                mode: LaunchMode.externalApplication),
            icon: const Icon(Icons.language),
            label: const Text('supercars-international.com'),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.number, required this.title, required this.text});

  final String number;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppTheme.brand.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(text, style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
