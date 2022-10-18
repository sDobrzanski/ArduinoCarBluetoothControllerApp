import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_production_boilerplate/repositories/bluetooth_repository.dart';

part 'bluetooth_device_state.dart';

class BluetoothDeviceCubit extends Cubit<BluetoothDeviceState> {
  BluetoothDeviceCubit(this._bluetoothRepository)
      : super(BluetoothDeviceInitial());

  static const String _prefix = 'BluetoothScanCubit';

  final BluetoothRepository _bluetoothRepository;

  Future<void> connectToDevice() async {
    try {
      emit(BluetoothDeviceLoading());
      //await _bluetoothRepository.connectToDevice(device);
      //emit(BluetoothDeviceConnected(device));
    } catch (e) {
      emit(BluetoothDeviceError(e.toString()));
      print('Error $_prefix connectToDevice: ${e.toString()}');
    }
  }

  Future<void> getCharacteristics() async {
    try {
      emit(BluetoothDeviceLoading());
      // final List<BluetoothCharacteristic> characteristics =
      //     await _bluetoothRepository.getCharacteristics(device);
      // emit(BluetoothDeviceCharacteristics(device, characteristics.first));
    } catch (e) {
      emit(BluetoothDeviceError(e.toString()));
      print('Error $_prefix getCharacteristics: ${e.toString()}');
    }
  }

  Future<void> disconnectFromDevice() async {
    try {
      emit(BluetoothDeviceLoading());
      // await _bluetoothRepository.disconnectFromDevice(device);
      emit(BluetoothDeviceDisconnected());
    } catch (e) {
      emit(BluetoothDeviceError(e.toString()));
      print('Error $_prefix disconnectFromDevice: ${e.toString()}');
    }
  }
}
