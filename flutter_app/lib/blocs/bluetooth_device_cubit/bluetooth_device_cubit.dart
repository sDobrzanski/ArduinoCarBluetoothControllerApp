import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_production_boilerplate/repositories/bluetooth_repository.dart';

part 'bluetooth_device_state.dart';

class BluetoothDeviceCubit extends Cubit<BluetoothDeviceState> {
  BluetoothDeviceCubit(this._bluetoothRepository)
      : super(BluetoothDeviceInitial());

  factory BluetoothDeviceCubit.create(BuildContext context) =>
      BluetoothDeviceCubit(RepositoryProvider.of<BluetoothRepository>(context));

  static const String _prefix = 'BluetoothScanCubit';

  final BluetoothRepository _bluetoothRepository;

  BluetoothDeviceWithConnection? get stateWithData =>
      state is BluetoothDeviceWithConnection
          ? (state as BluetoothDeviceWithConnection)
          : null;

  bool isConnected(String deviceAddress) =>
      state is BluetoothDeviceConnected &&
      (state as BluetoothDeviceConnected).isDeviceConnected(deviceAddress);

  Future<void> changeConnectionStatus(BluetoothDevice device) async {
    try {
      if (stateWithData == null) {
        //Connect to device
        final BluetoothConnection connection =
            await _bluetoothRepository.getConnection(device);
        emit(BluetoothDeviceConnected(device, connection));
      } else {
        //Disconnect from device
        if (device.address == stateWithData!.device.address) {
          _bluetoothRepository.closeConnection(stateWithData!.connection);
          emit(const BluetoothDeviceDisconnected());
        }
      }
    } catch (e) {
      emit(BluetoothDeviceError(e.toString()));
      print('Error $_prefix changeConnectionStatus: ${e.toString()}');
    }
  }

  void sendData(String data) {
    try {
      if (stateWithData?.connection != null) {
        _bluetoothRepository.sendData(stateWithData!.connection, data);
        emit(
          BluetoothDeviceDataSent(
            stateWithData!.device,
            stateWithData!.connection,
            data,
          ),
        );
      } else {
        throw Exception('No connection');
      }
    } catch (e) {
      emit(BluetoothDeviceError(e.toString()));
      print('Error $_prefix sendData: ${e.toString()}');
    }
  }
}
