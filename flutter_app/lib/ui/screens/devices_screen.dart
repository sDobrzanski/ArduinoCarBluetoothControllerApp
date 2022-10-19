import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ionicons/ionicons.dart';

import '../../blocs/bluetooth_device_cubit/bluetooth_device_cubit.dart';
import '../../blocs/bluetooth_scan_cubit/bluetooth_scan_cubit.dart';
import '../../utils/dialog_snackbars.dart';
import '../widgets/first_screen/info_card.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  late BluetoothScanCubit bluetoothScanCubit;
  final List<BluetoothDiscoveryResult> discoveries =
      <BluetoothDiscoveryResult>[];

  @override
  void didChangeDependencies() {
    bluetoothScanCubit = BlocProvider.of<BluetoothScanCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<BluetoothDeviceCubit, BluetoothDeviceState>(
        listener: (BuildContext context, BluetoothDeviceState state) {
          if (state is BluetoothDeviceConnected) {
            showConnectionSnackbar(context, state.message);
          } else if (state is BluetoothDeviceDisconnected) {
            showConnectionSnackbar(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: StreamBuilder<BluetoothDiscoveryResult>(
              stream: BlocProvider.of<BluetoothScanCubit>(context)
                  .discoveryStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<BluetoothDiscoveryResult> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text('Error with scanning for devices');
                } else if (snapshot.hasData) {
                  discoveries.add(snapshot.data!);
                  discoveries.toSet().toList();
                }
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  padding: EdgeInsets.zero,
                  children: [
                    for (BluetoothDiscoveryResult result
                        in discoveries.toSet().toList())
                      InfoCard(
                        deviceName: result.device.name ?? '',
                        deviceAddress: result.device.address,
                        onTap: () =>
                            BlocProvider.of<BluetoothDeviceCubit>(context)
                                .changeConnectionStatus(result.device),
                      ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bluetoothScanCubit.cancelDiscovery();
    super.dispose();
  }
}
