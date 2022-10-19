import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'blocs/bluetooth_device_cubit/bluetooth_device_cubit.dart';
import 'blocs/bluetooth_scan_cubit/bluetooth_scan_cubit.dart';
import 'main.dart';
import 'repositories/bluetooth_repository.dart';

class GlobalProviders extends StatelessWidget {
  GlobalProviders({super.key}) {
    _flutterBluetoothSerial = FlutterBluetoothSerial.instance;
  }

  late final FlutterBluetoothSerial _flutterBluetoothSerial;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BluetoothRepository>(
          create: (BuildContext context) => BluetoothRepository(
            _flutterBluetoothSerial,
          ),
        )
      ],
      child: Builder(
        builder: (BuildContext context) => MultiBlocProvider(providers: [
          BlocProvider<BluetoothScanCubit>(
            create: (BuildContext context) =>
                BluetoothScanCubit.create(context),
          ),
          BlocProvider<BluetoothDeviceCubit>(
            create: (BuildContext context) =>
                BluetoothDeviceCubit.create(context),
          ),
        ], child: const MyApp()),
      ),
    );
  }
}
