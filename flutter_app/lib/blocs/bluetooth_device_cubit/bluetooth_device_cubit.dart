import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_production_boilerplate/repositories/bluetooth_repository.dart';

part 'bluetooth_device_state.dart';

class BluetoothDeviceCubit extends Cubit<BluetoothDeviceState> {
  BluetoothDeviceCubit(this._bluetoothRepository)
      : super(BluetoothDeviceInitial());

  static const String _prefix = 'BluetoothScanCubit';

  final BluetoothRepository _bluetoothRepository;

  BluetoothConnection? get connectionToDevice =>
      state is BluetoothDeviceWithConnection
          ? (state as BluetoothDeviceWithConnection).connection
          : null;

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      emit(BluetoothDeviceLoading());
      final BluetoothConnection connection =
          await _bluetoothRepository.getConnection(device);
      emit(BluetoothDeviceConnected(connection));
    } catch (e) {
      emit(BluetoothDeviceError(e.toString()));
      print('Error $_prefix connectToDevice: ${e.toString()}');
    }
  }

  void sendData(String data) {
    try {
      if (connectionToDevice != null) {
        _bluetoothRepository.sendData(connectionToDevice!, data);
        emit(BluetoothDeviceDataSent(connectionToDevice!, data));
      } else {
        throw Exception('No connection');
      }
    } catch (e) {
      emit(BluetoothDeviceError(e.toString()));
      print('Error $_prefix sendData: ${e.toString()}');
    }
  }

  void disconnectFromDevice() {
    try {
      if (connectionToDevice != null) {
        _bluetoothRepository.closeConnection(connectionToDevice!);
        emit(BluetoothDeviceDisconnected());
      } else {
        throw Exception('No connection');
      }
    } catch (e) {
      emit(BluetoothDeviceError(e.toString()));
      print('Error $_prefix disconnectFromDevice: ${e.toString()}');
    }
  }
}
