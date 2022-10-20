import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_production_boilerplate/blocs/bluetooth_scan_cubit/bluetooth_scan_cubit.dart';

import '../../cubit/bottom_nav_cubit.dart';
import '../widgets/bottom_nav_bar.dart';
import 'device_details_screen.dart';
import 'devices_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BluetoothScanCubit>(context).discoverDevices();
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> pageNavigation = <Widget>[
      DevicesScreen(),
      DeviceDetailsScreen(),
    ];

    return BlocProvider<BottomNavCubit>(
        create: (BuildContext context) => BottomNavCubit(),
        child: Scaffold(
          body: BlocBuilder<BottomNavCubit, int>(
            builder: (BuildContext context, int state) {
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: pageNavigation.elementAt(state));
            },
          ),
          bottomNavigationBar: const BottomNavBar(),
          backgroundColor: Theme.of(context).colorScheme.background,
        ));
  }
}
