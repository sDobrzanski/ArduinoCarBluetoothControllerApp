part of 'bluetooth_device_cubit.dart';

abstract class BluetoothDeviceState extends Equatable {
  const BluetoothDeviceState();

  @override
  List<Object?> get props => [];
}

class BluetoothDeviceLoading extends BluetoothDeviceState {}

class BluetoothDeviceInitial extends BluetoothDeviceState {}

abstract class BluetoothDeviceWithConnection extends BluetoothDeviceState {
  const BluetoothDeviceWithConnection(this.device, this.connection);

  final BluetoothDevice device;
  final BluetoothConnection connection;

  @override
  List<Object?> get props => [device, connection];
}

class BluetoothDeviceConnected extends BluetoothDeviceWithConnection {
  const BluetoothDeviceConnected(
    super.device,
    super.connection, {
    this.message = 'Connected with device',
  });

  final String message;

  bool isDeviceConnected(String deviceAddress) =>
      deviceAddress == device.address;

  @override
  List<Object?> get props => [device, connection, message];
}

class BluetoothDeviceDataSent extends BluetoothDeviceWithConnection {
  const BluetoothDeviceDataSent(super.device, super.connection, this.data);

  final String data;

  @override
  List<Object?> get props => [super.connection, data];
}

class BluetoothDeviceDisconnected extends BluetoothDeviceState {
  const BluetoothDeviceDisconnected({
    this.message = 'Disconnected from device',
  });

  final String message;

  @override
  List<Object?> get props => [message];
}

class BluetoothDeviceError extends BluetoothDeviceState {
  const BluetoothDeviceError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
