import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';


class BluetoothRepository {
  const BluetoothRepository(
    this.flutterBluetoothSerial,
  );

  final FlutterBluetoothSerial flutterBluetoothSerial;
  //
  // void starScanningForDevices() =>
  //     flutterBlue.startScan(timeout: timeoutDuration);
  //
  // Stream<List<ScanResult>> scanResultsStream() => flutterBlue.scanResults;
  //
  // void stopScanningForDevices() => flutterBlue.stopScan();
  //
  // Future<void> connectToDevice(ScanResult result) async {
  //   await result.device.connect();
  // }
  //
  // Future<List<BluetoothCharacteristic>> getCharacteristics(
  //     ScanResult result) async {
  //   final List<BluetoothCharacteristic> deviceCharacteristics =
  //       <BluetoothCharacteristic>[];
  //
  //   final List<BluetoothService> services =
  //       await result.device.discoverServices();
  //
  //   services.forEach((BluetoothService service) async {
  //     deviceCharacteristics.addAll(service.characteristics);
  //   });
  //
  //   return deviceCharacteristics;
  // }
  //
  // Future<void> sendDataToDevice(
  //     BluetoothCharacteristic characteristic, String message) async {
  //   await characteristic.write(utf8.encode(message));
  // }
  //
  // Future<void> disconnectFromDevice(ScanResult result) async {
  //   await result.device.disconnect();
  // }

  Stream<BluetoothDiscoveryResult> discoveryStream() =>
      flutterBluetoothSerial.startDiscovery();

  Future<void> cancelDiscovery() async {
    await flutterBluetoothSerial.cancelDiscovery();
  }
}
