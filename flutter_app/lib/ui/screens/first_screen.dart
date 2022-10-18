import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ionicons/ionicons.dart';

import '../../blocs/bluetooth_scan_cubit/bluetooth_scan_cubit.dart';
import '../widgets/first_screen/info_card.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: StreamBuilder<BluetoothDiscoveryResult>(
            stream:
                BlocProvider.of<BluetoothScanCubit>(context).discoveryStream(),
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
                      title: result.device.name ?? '',
                      content: result.device.address,
                      icon: Ionicons.bluetooth,
                      isPrimaryColor: true,
                    ),
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    bluetoothScanCubit.cancelDiscovery();
    super.dispose();
  }
}
