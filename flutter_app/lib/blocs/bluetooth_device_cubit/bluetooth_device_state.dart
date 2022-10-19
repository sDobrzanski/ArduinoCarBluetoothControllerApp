part of 'bluetooth_device_cubit.dart';

abstract class BluetoothDeviceState extends Equatable {
  const BluetoothDeviceState();

  @override
  List<Object?> get props => [];
}

class BluetoothDeviceLoading extends BluetoothDeviceState {}

class BluetoothDeviceInitial extends BluetoothDeviceState {}

abstract class BluetoothDeviceWithConnection extends BluetoothDeviceState {
  const BluetoothDeviceWithConnection(this.connection);

  final BluetoothConnection connection;

  @override
  List<Object?> get props => [connection];
}

class BluetoothDeviceConnected extends BluetoothDeviceWithConnection {
  const BluetoothDeviceConnected(super.connection);
}

class BluetoothDeviceDataSent extends BluetoothDeviceWithConnection {
  const BluetoothDeviceDataSent(super.connection, this.data);

  final String data;

  @override
  List<Object?> get props => [super.connection, data];
}

class BluetoothDeviceDisconnected extends BluetoothDeviceState {}

class BluetoothDeviceError extends BluetoothDeviceState {
  const BluetoothDeviceError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
