part of 'bluetooth_scan_cubit.dart';

abstract class BluetoothScanState extends Equatable {
  const BluetoothScanState();

  @override
  List<Object?> get props => [];
}

class BluetoothScanInitial extends BluetoothScanState {}

class BluetoothScanLoading extends BluetoothScanState {}

class BluetoothScanSuccess extends BluetoothScanState {
  const BluetoothScanSuccess(this.discoveries, this.time);

  final List<BluetoothDiscoveryResult> discoveries;
  final String time;

  @override
  List<Object?> get props => [discoveries, time];
}

class BluetoothScanError extends BluetoothScanState {
  const BluetoothScanError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

