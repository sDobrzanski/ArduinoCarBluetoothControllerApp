import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_production_boilerplate/blocs/bluetooth_device_cubit/bluetooth_device_cubit.dart';
import 'package:ionicons/ionicons.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({
    super.key,
    required this.deviceName,
    required this.deviceAddress,
    required this.onTap,
  });

  final String deviceName;
  final String deviceAddress;
  final VoidCallback onTap;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  late bool isConnected;

  @override
  void initState() {
    super.initState();
    isConnected = BlocProvider.of<BluetoothDeviceCubit>(context)
        .isConnected(widget.deviceAddress);
  }

  TextTheme get textTheme => isConnected
      ? Theme.of(context).primaryTextTheme
      : Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BluetoothDeviceCubit, BluetoothDeviceState>(
      listener: (BuildContext context, BluetoothDeviceState state) {
        if (state is BluetoothDeviceConnected) {
          setState(() {
            isConnected = state.isDeviceConnected(widget.deviceAddress);
          });
        } else if (state is BluetoothDeviceDisconnected) {
          setState(() {
            isConnected = false;
          });
        }
      },
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
          elevation: 2,
          shadowColor: Theme.of(context).colorScheme.shadow,
          color: isConnected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.deviceName,
                  style: textTheme.titleLarge!.apply(fontWeightDelta: 2),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.deviceAddress,
                  style: textTheme.bodyMedium,
                ),
                const Spacer(),
                Icon(
                  Ionicons.bluetooth,
                  size: 32,
                  color: textTheme.bodyMedium!.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
