part of 'bluetooth_device_cubit.dart';

abstract class BluetoothDeviceState extends Equatable {
  const BluetoothDeviceState();

  @override
  List<Object?> get props => [];
}

class BluetoothDeviceLoading extends BluetoothDeviceState {}

class BluetoothDeviceInitial extends BluetoothDeviceState {}

class BluetoothDeviceConnected extends BluetoothDeviceState {}

class BluetoothDeviceDisconnected extends BluetoothDeviceState {}

class BluetoothDeviceError extends BluetoothDeviceState {
  const BluetoothDeviceError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
