import 'dart:convert';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothRepository {
  const BluetoothRepository(
    this.flutterBluetoothSerial,
  );

  final FlutterBluetoothSerial flutterBluetoothSerial;

  Stream<BluetoothDiscoveryResult> discoveryStream() =>
      flutterBluetoothSerial.startDiscovery();

  Future<void> cancelDiscovery() async {
    await flutterBluetoothSerial.cancelDiscovery();
  }

  Future<BluetoothConnection> getConnection(BluetoothDevice device) =>
      BluetoothConnection.toAddress(device.address);

  void sendData(BluetoothConnection connection, String data) {
    connection.output.add(ascii.encode(data));
  }

  void closeConnection(BluetoothConnection connection) {
    connection.close();
  }
}
