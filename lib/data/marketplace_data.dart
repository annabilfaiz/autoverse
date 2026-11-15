import 'models/product_model.dart';

class MarketplaceData {
  MarketplaceData._();

  static List<ProductModel> getInitialProducts() {
    return [
      ProductModel(
        id: 'prod_01',
        name: 'Akrapovič Evolution Line Titanium Full System',
        brand: 'Akrapovič',
        category: 'Exhaust',
        priceIdr: 48500000,
        sellerName: 'AK Parts Jakarta',
        sellerUsername: '@ak_parts_jkt',
        description:
            'Full titanium exhaust system engineered specifically for the Porsche 911 GT3 992.1. '
            'Combines a high-flow racing header with a titanium muffler and carbon fiber end cap. '
            '+22 HP, -11 kg. Includes all OEM mounting brackets and bolts.',
        specifications: {
          'Material': 'Grade 5 Titanium + Carbon Fiber',
          'Power Gain': '+22 HP',
          'Weight Reduction': '-11 kg vs OEM',
          'DB Level': '102 dB (Sport) / 94 dB (Comfort)',
          'Certificate': 'EC Type Approval',
          'Country of Origin': 'Slovenia',
        },
        compatibleVehicles: [
          'Porsche 911 GT3 992 (2021–2024)',
          'Porsche 911 GT3 RS 992 (2022–2024)',
        ],
        imageAsset: 'assets/images/products/product_titanium_exhaust.jpg',
        isSaved: true,
        condition: 'New',
        stock: 2,
      ),
      ProductModel(
        id: 'prod_02',
        name: 'BBS FI-R Monobloc Forged Wheel Set',
        brand: 'BBS',
        category: 'Wheels',
        priceIdr: 68000000,
        sellerName: 'Premium Wheels ID',
        sellerUsername: '@premwheels_id',
        description:
            'BBS FI-R one-piece forged aluminum wheel in Matte Black with machined lip. '
            'Race-proven technology used in GT3 Cup series. 10-spoke design optimized for '
            'aerodynamic drag reduction and thermal management. Set of 4 includes hardware.',
        specifications: {
          'Size': '20" (Front 9.5J, Rear 12J)',
          'Offset': 'Front ET38, Rear ET47',
          'Center Bore': '71.6mm',
          'Material': 'Forged 6061-T6 Aluminium',
          'PCD': '5×130',
          'Weight': '9.4 kg / wheel',
        },
        compatibleVehicles: [
          'Porsche 911 GT3 992 (2021–2024)',
          'Porsche 911 Carrera 992 (2019–2024)',
          'Porsche 911 Turbo S 992 (2020–2024)',
        ],
        imageAsset: 'assets/images/products/product_forged_wheel.jpg',
        condition: 'New',
        stock: 1,
      ),
      ProductModel(
        id: 'prod_03',
        name: 'Performance Adjustable Coilover Kit',
        brand: 'ClubSport Spec',
        category: 'Suspension',
        priceIdr: 22500000,
        sellerName: 'JDM Garage BDG',
        sellerUsername: '@jdm_bdg',
        description:
            'Full coilover system with continuous damping adjustment and external piggyback reservoirs. '
            'Separated bump and rebound knobs allow precise setup for street and circuit use. '
            'Premium anodized aluminium body with linear yellow motorsport springs. Compatible with Mazda RX-7 FD3S.',
        specifications: {
          'Adjustment': '2-Way Bump & Rebound',
          'Spring Rate (Front)': '6 kg/mm',
          'Spring Rate (Rear)': '5 kg/mm',
          'Ride Height': '-15mm to -50mm',
          'Material': 'Anodized Aluminium + Linear Springs',
          'Warranty': '1 Year Motorsport ID',
        },
        compatibleVehicles: ['Mazda RX-7 FD3S (1992–2002)'],
        imageAsset: 'assets/images/products/product_performance_coilover.jpg',
        condition: 'New',
        stock: 3,
      ),
      ProductModel(
        id: 'prod_04',
        name: 'Carbon-Ceramic Big Brake Kit',
        brand: 'Monobloc Racing',
        category: 'Brakes',
        priceIdr: 87500000,
        sellerName: 'Track Parts ID',
        sellerUsername: '@trackparts_id',
        description:
            'Complete high-performance carbon-ceramic brake system. '
            'Includes cross-drilled carbon-ceramic composite rotors and lightweight monobloc 6-piston red racing calipers. '
            'Optimal fade resistance up to 900°C with massive weight savings over cast-iron systems. Compatible with Porsche 911 GT3.',
        specifications: {
          'Rotor Material': 'Carbon-Ceramic Composite (410mm)',
          'Caliper Spec': '6-Piston Monobloc Red Finish',
          'Temp Range': '300°C – 900°C',
          'Contents': '2 Rotors, 2 Calipers, Pads, Mounting Kit',
          'Dust Level': 'Ultra Low',
          'Weight Saving': '-18 kg vs Cast Iron',
        },
        compatibleVehicles: [
          'Porsche 911 GT3 992 (2021–2024)',
          'Porsche 911 GT3 991 (2013–2019)',
          'Porsche 911 Turbo S 992 (2020–2024)',
        ],
        imageAsset: 'assets/images/products/product_carbon_ceramic_brake.jpg',
        condition: 'New',
        stock: 2,
      ),
      ProductModel(
        id: 'prod_05',
        name: 'RE-Amemiya Wide Body Aero Kit FD3S',
        brand: 'RE-Amemiya',
        category: 'Exterior',
        priceIdr: 32000000,
        sellerName: 'Rotary Kingdom ID',
        sellerUsername: '@rotary_kingdom',
        description:
            'Iconic RE-Amemiya full wide-body conversion kit for the Mazda RX-7 FD3S. '
            'Includes front bumper, rear bumper, side skirts, over-fenders (+50mm per side), '
            'and front carbon canards. FRP material, requires paint.',
        specifications: {
          'Material': 'FRP (Fiber Reinforced Plastic)',
          'Overfender Width': '+50mm each side',
          'Includes': 'Front, Rear, Skirts, Fenders, Canards',
          'Paint': 'Unpainted / Primer only',
          'Origin': 'Japan',
          'Install Time': '8–12 hours',
        },
        compatibleVehicles: ['Mazda RX-7 FD3S (1992–2002)'],
        imageAsset: 'assets/images/products/product_placeholder.jpg',
        condition: 'New',
        stock: 2,
      ),
      ProductModel(
        id: 'prod_06',
        name: 'Toda Racing High-Power Camshaft Set K20C1',
        brand: 'Toda Racing',
        category: 'Engine',
        priceIdr: 18000000,
        sellerName: 'Honda Tuners JKT',
        sellerUsername: '@hondatuners_jkt',
        description:
            'Direct-replacement high-lift camshaft set for the Honda K20C1 Type R engine. '
            'Increases peak power by +18 HP and broadens the power band. '
            'Requires professional installation and ECU re-tune.',
        specifications: {
          'Intake Duration': '260°',
          'Exhaust Duration': '256°',
          'Intake Lift': '10.5mm',
          'Exhaust Lift': '10.1mm',
          'Material': 'Billet Steel',
          'Origin': 'Japan',
        },
        compatibleVehicles: [
          'Honda Civic Type R FK8 (2017–2021)',
          'Honda Civic Type R FL5 (2022–2024)',
        ],
        imageAsset: 'assets/images/products/product_placeholder.jpg',
        condition: 'New',
        stock: 1,
      ),
      ProductModel(
        id: 'prod_07',
        name: 'OMP WRC Bucket Racing Seat',
        brand: 'OMP',
        category: 'Interior',
        priceIdr: 12000000,
        sellerName: 'Speed Shop BSD',
        sellerUsername: '@speedshop_bsd',
        description:
            'FIA-approved OMP WRC composite bucket seat with side bolsters and integrated harness slots. '
            'Ultra-light at 4.9 kg. Sold as single seat with side mounts.',
        specifications: {
          'Weight': '4.9 kg',
          'Homologation': 'FIA 8855-1999 / 2016',
          'Shell': 'Carbon / Kevlar composite',
          'Width (Shoulder)': '490mm',
          'Width (Hip)': '295mm',
          'Color': 'Black / Red',
        },
        compatibleVehicles: ['Universal (Bracket sold separately)'],
        imageAsset: 'assets/images/products/product_placeholder.jpg',
        isSaved: true,
        condition: 'New',
        stock: 4,
      ),
      ProductModel(
        id: 'prod_08',
        name: 'HKS GT2 Super Power Flow Air Intake Kit',
        brand: 'HKS',
        category: 'Engine',
        priceIdr: 4200000,
        sellerName: 'JDM Garage BDG',
        sellerUsername: '@jdm_bdg',
        description:
            'Complete cold-air intake upgrade for the Mazda RX-7 FD3S with twin sequential turbos. '
            'Reusable dry filter, aluminium intake piping, included clamps and brackets.',
        specifications: {
          'Filter Type': 'Dry Flow Reusable',
          'Pipe Diameter': '76mm',
          'Material': 'Polished Aluminium',
          'Gains': '+8 HP, +12 Nm',
          'Install Time': '1–2 hours',
        },
        compatibleVehicles: ['Mazda RX-7 FD3S (1992–2002)'],
        imageAsset: 'assets/images/products/product_placeholder.jpg',
        condition: 'Used',
        stock: 1,
      ),
    ];
  }
}
