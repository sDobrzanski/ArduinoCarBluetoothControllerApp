import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_production_boilerplate/ui/widgets/header.dart';
import 'package:vector_math/vector_math.dart';

class ControlScreenBody extends StatefulWidget {
  const ControlScreenBody({super.key});

  @override
  State<ControlScreenBody> createState() => _ControlScreenBodyState();
}

class _ControlScreenBodyState extends State<ControlScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Header(
            text: 'Car controller',
            padding: EdgeInsets.only(left: 2, right: 2, bottom: 24),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Joystick(
              listener: (StickDragDetails details) {
                setState(() {
                  final double radianValue = atan2(details.x, details.y);
                  final double degreeValue = 180 - degrees(radianValue);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
