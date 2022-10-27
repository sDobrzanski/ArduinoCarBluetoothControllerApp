import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
    this.padding,
  });

  final String text;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(left: 2, right: 2, top: 48, bottom: 24),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .apply(fontWeightDelta: 2),
      ),
    );
  }
}
