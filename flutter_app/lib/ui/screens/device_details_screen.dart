import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:routemaster/routemaster.dart';

import '../../blocs/bluetooth_device_cubit/bluetooth_device_cubit.dart';
import '../widgets/control_screen/device_info_card.dart';
import '../widgets/header.dart';
import 'control_screen.dart';

class DeviceDetailsScreen extends StatelessWidget {
  const DeviceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BluetoothDeviceCubit, BluetoothDeviceState>(
        builder: (BuildContext context, BluetoothDeviceState state) {
          if (state is BluetoothDeviceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BluetoothDeviceWithConnection) {
            return SingleChildScrollView(
              child: Column(children: <Widget>[
                const Header(text: 'Device details'),
                DeviceInfoCard(
                  title: state.device.name ?? '',
                  icon: Ionicons.bluetooth,
                  address: state.device.address,
                ),
                TextButton(
                    onPressed: () =>
                        Routemaster.of(context).push(ControlScreen.route),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Use remote controller',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )),
              ]),
            );
          } else {
            return const Center(
              child: Text("You aren't connected to any device"),
            );
          }
        },
      ),
    );
  }
}
