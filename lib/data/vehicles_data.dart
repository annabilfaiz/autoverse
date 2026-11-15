import 'models/vehicle_model.dart';

class VehiclesData {
  VehiclesData._();

  static List<VehicleModel> getAdityaGarageVehicles() {
    return const [
      VehicleModel(
        id: 'veh_porsche_gt3',
        manufacturer: 'Porsche',
        model: '911 GT3',
        year: 2022,
        generation: '992.1',
        nickname: 'Signature Build',
        imageAsset: 'assets/images/vehicles/vehicle_porsche_911_gt3_hero.jpg',
        status: 'Active Build',
        specs: {
          'Engine': '4.0L Naturally Aspirated Boxer-6',
          'Power': '502 HP (+22 HP Akrapovič)',
          'Torque': '470 Nm',
          'Transmission': '7-speed PDK',
          'Weight': '1,435 kg (-11 kg Titanium)',
        },
      ),
      VehicleModel(
        id: 'veh_mazda_rx7',
        manufacturer: 'Mazda',
        model: 'RX-7',
        year: 1994,
        generation: 'FD3S',
        nickname: 'Rotary Track Spec',
        imageAsset: 'assets/images/vehicles/vehicle_mazda_rx7_fd3s_hero.jpg',
        status: 'In Progress',
        specs: {
          'Engine': '13B-REW Twin-Rotary Bridge Port',
          'Power': '420 WHP @ 1.1 bar',
          'Transmission': '5-speed Manual',
        },
      ),
      VehicleModel(
        id: 'veh_civic_fk8',
        manufacturer: 'Honda',
        model: 'Civic Type R',
        year: 2018,
        generation: 'FK8',
        nickname: 'Daily Track Spec',
        imageAsset:
            'assets/images/vehicles/vehicle_honda_civic_type_r_fk8_hero.jpg',
        status: 'Active Daily',
        specs: {
          'Engine': '2.0L Turbocharged K20C1',
          'Power': '306 HP',
          'Torque': '400 Nm',
          'Transmission': '6-speed Manual',
        },
      ),
    ];
  }
}
