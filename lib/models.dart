enum VehicleCondition { nuevo, usado }

extension VehicleConditionLabel on VehicleCondition {
  String get label => switch (this) {
        VehicleCondition.nuevo => '0KM',
        VehicleCondition.usado => 'Usado',
      };
}

class Vehicle {
  const Vehicle({
    required this.brand,
    required this.model,
    required this.year,
    required this.condition,
    required this.engine,
    required this.transmission,
    required this.horsepower,
    required this.fuelEconomy,
    required this.highlights,
    required this.vehiclePrice,
    required this.landedPrice,
    this.featured = false,
    this.images = const [],
  });

  /// Bundled asset paths of real photos, when the site provides them.
  final List<String> images;

  final String brand;
  final String model;
  final int year;
  final VehicleCondition condition;
  final String engine;
  final String transmission;
  final String horsepower;
  final String fuelEconomy;
  final List<String> highlights;
  final String vehiclePrice;
  final String landedPrice;
  final bool featured;
}

class Catalog {
  Catalog._();

  static const whatsappNumber = '584220234582';
  static const siteUrl = 'https://supercars-international.com';

  static const vehicles = <Vehicle>[
    Vehicle(
      brand: 'Toyota', model: 'Corolla Levin 1.5L', year: 2023,
      condition: VehicleCondition.usado,
      engine: '1.5L 3-cil.', transmission: 'CVT · FWD', horsepower: '113 hp',
      fuelEconomy: '~18 km/L',
      highlights: ['6 Airbags', 'Pantalla 7" multimedia', 'Baja rodada', 'Inspección documentada'],
      vehiclePrice: 'US\$ 7.850', landedPrice: 'US\$ 22.850', featured: true,
      images: [
        'assets/images/vehicles/levin-frontal.jpeg',
        'assets/images/vehicles/levin-lateral.jpeg',
        'assets/images/vehicles/levin-desde_atras.jpeg',
        'assets/images/vehicles/levin-tablero.jpeg',
      ],
    ),
    Vehicle(
      brand: 'Toyota', model: 'Camry Sport', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '2.0L 4-cil.', transmission: 'CVT · FWD', horsepower: '169 hp',
      fuelEconomy: '~15 km/L',
      highlights: ['Toyota Safety Sense', 'Pantalla 9"', 'Sunroof'],
      vehiclePrice: 'US\$ 19.900', landedPrice: 'US\$ 38.500',
    ),
    Vehicle(
      brand: 'Toyota', model: 'Corolla Cross', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '1.8L Híbrido', transmission: 'e-CVT · FWD', horsepower: '121 hp',
      fuelEconomy: '~20 km/L',
      highlights: ['Híbrido', 'Toyota Safety Sense', 'Cámara 360°'],
      vehiclePrice: 'US\$ 17.400', landedPrice: 'US\$ 34.900',
    ),
    Vehicle(
      brand: 'Toyota', model: 'Corolla Cross Elite', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '2.0L 4-cil.', transmission: 'CVT · FWD', horsepower: '169 hp',
      fuelEconomy: '~15 km/L',
      highlights: ['Cuero', 'Techo panorámico', 'Pantalla 10.25"'],
      vehiclePrice: 'US\$ 19.200', landedPrice: 'US\$ 37.800',
    ),
    Vehicle(
      brand: 'Toyota', model: 'RAV4 4x4', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '2.0L 4-cil.', transmission: 'CVT · AWD', horsepower: '171 hp',
      fuelEconomy: '~14 km/L',
      highlights: ['Tracción 4x4', 'Multi-Terrain Select', 'Toyota Safety Sense'],
      vehiclePrice: 'US\$ 21.500', landedPrice: 'US\$ 41.900',
    ),
    Vehicle(
      brand: 'Toyota', model: 'RAV4 Luxury', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '2.5L Híbrido', transmission: 'e-CVT · AWD', horsepower: '219 hp',
      fuelEconomy: '~18 km/L',
      highlights: ['Híbrido AWD', 'Cuero ventilado', 'JBL premium'],
      vehiclePrice: 'US\$ 26.800', landedPrice: 'US\$ 49.900',
    ),
    Vehicle(
      brand: 'Toyota', model: 'Highlander 7 plazas', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '2.5L Híbrido', transmission: 'e-CVT · AWD', horsepower: '243 hp',
      fuelEconomy: '~16 km/L',
      highlights: ['7 asientos', 'Híbrido', 'Pantalla 12.3"'],
      vehiclePrice: 'US\$ 32.400', landedPrice: 'US\$ 58.900',
    ),
    Vehicle(
      brand: 'Toyota', model: 'Highlander Premium', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '2.4L Turbo', transmission: '8AT · AWD', horsepower: '265 hp',
      fuelEconomy: '~12 km/L',
      highlights: ['7 asientos', 'Head-up display', 'Techo panorámico'],
      vehiclePrice: 'US\$ 36.900', landedPrice: 'US\$ 65.900',
    ),
    Vehicle(
      brand: 'Toyota', model: 'Frontlander 2.0L', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '2.0L 4-cil.', transmission: 'CVT · FWD', horsepower: '171 hp',
      fuelEconomy: '~14 km/L',
      highlights: ['SUV compacto', 'Toyota Safety Sense', 'Pantalla 10.25"'],
      vehiclePrice: 'US\$ 15.900', landedPrice: 'US\$ 32.500',
    ),
    Vehicle(
      brand: 'Toyota', model: 'Frontlander Deluxe Plus', year: 2024,
      condition: VehicleCondition.nuevo,
      engine: '2.0L Híbrido', transmission: 'e-CVT · FWD', horsepower: '152 hp',
      fuelEconomy: '~19 km/L',
      highlights: ['Híbrido', 'Cuero', 'Cámara 360°'],
      vehiclePrice: 'US\$ 18.700', landedPrice: 'US\$ 36.400',
    ),
  ];

  static List<String> get brands =>
      ['Todos', ...{...vehicles.map((v) => v.brand)}.toList()..sort()];

  static const destinations = [
    'Venezuela', 'Colombia', 'Panamá', 'Rep. Dominicana', 'México', 'USA', 'Brasil',
  ];
}
