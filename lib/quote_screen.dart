import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';
import 'theme.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key, this.vehicle});

  final Vehicle? vehicle;

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _budget = TextEditingController();
  final _notes = TextEditingController();
  String _destination = 'Venezuela';
  String? _model;

  String get _modelText => _model ??
      (widget.vehicle != null
          ? '${widget.vehicle!.brand} ${widget.vehicle!.model} ${widget.vehicle!.year}'
          : 'No especificado');

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _budget.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _sendQuote() async {
    final text = 'Hola Super Cars International, quiero una cotización.\n'
        'Vehículo: $_modelText\n'
        'Destino: $_destination\n'
        'Nombre: ${_name.text.isEmpty ? "—" : _name.text}\n'
        'Teléfono: ${_phone.text.isEmpty ? "—" : _phone.text}\n'
        'Presupuesto: ${_budget.text.isEmpty ? "—" : "US\$ ${_budget.text}"}\n'
        'Notas: ${_notes.text.isEmpty ? "—" : _notes.text}';
    await launchUrl(
      Uri.parse('https://wa.me/${Catalog.whatsappNumber}?text=${Uri.encodeComponent(text)}'),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cotizar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionHeader('Vehículo'),
          if (widget.vehicle == null)
            DropdownButtonFormField<String>(
              initialValue: _model,
              decoration: const InputDecoration(labelText: 'Modelo'),
              items: [
                const DropdownMenuItem(value: null, child: Text('Selecciona un modelo')),
                for (final v in Catalog.vehicles)
                  DropdownMenuItem(
                    value: '${v.brand} ${v.model} ${v.year}',
                    child: Text('${v.brand} ${v.model}'),
                  ),
              ],
              onChanged: (v) => setState(() => _model = v),
            )
          else
            InputDecorator(
              decoration: const InputDecoration(labelText: 'Modelo'),
              child: Text(_modelText),
            ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _destination,
            decoration: const InputDecoration(labelText: 'Destino'),
            items: [
              for (final d in Catalog.destinations)
                DropdownMenuItem(value: d, child: Text(d)),
            ],
            onChanged: (v) => setState(() => _destination = v ?? _destination),
          ),
          const _SectionHeader('Tus datos'),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Teléfono / WhatsApp'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _budget,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Presupuesto (US\$)'),
          ),
          const _SectionHeader('Notas'),
          TextField(
            controller: _notes,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Color, equipamiento, preguntas…',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.ink,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: _sendQuote,
            child: const Text('Enviar cotización por WhatsApp'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.4,
          color: AppTheme.heroGold,
        ),
      ),
    );
  }
}
