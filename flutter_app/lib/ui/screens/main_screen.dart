import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/bottom_nav_cubit.dart';
import '../widgets/bottom_nav_bar.dart';
import 'device_details_screen.dart';
import 'devices_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
