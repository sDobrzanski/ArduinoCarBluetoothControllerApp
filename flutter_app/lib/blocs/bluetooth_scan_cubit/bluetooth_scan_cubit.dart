import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_production_boilerplate/repositories/bluetooth_repository.dart';

part 'bluetooth_scan_state.dart';

class BluetoothScanCubit extends Cubit<BluetoothScanState> {
  BluetoothScanCubit(this._bluetoothRepository) : super(BluetoothScanInitial());

  factory BluetoothScanCubit.create(BuildContext context) =>
      BluetoothScanCubit(RepositoryProvider.of<BluetoothRepository>(context));

  static const String _prefix = 'BluetoothScanCubit';

  final BluetoothRepository _bluetoothRepository;

  void discoverDevices() {
    try {
      emit(BluetoothScanLoading());
      final List<BluetoothDiscoveryResult> discoveries =
          <BluetoothDiscoveryResult>[];
      _bluetoothRepository
          .discoveryStream()
          .listen((BluetoothDiscoveryResult result) {
        discoveries.add(result);
        emit(BluetoothScanSuccess(discoveries, DateTime.now().toString()));
      });
    } catch (e) {
      emit(BluetoothScanError(e.toString()));
      print('Error $_prefix discoveryDevices: ${e.toString()}');
    }
  }

  Future<void> cancelDiscovery() async {
    try {
      await _bluetoothRepository.cancelDiscovery();
    } catch (e) {
      print('Error $_prefix cancelDiscovery: ${e.toString()}');
    }
  }
}
