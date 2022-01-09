import 'package:flutter/material.dart';

class ToolSwitch extends StatelessWidget {
  const ToolSwitch({
    Key? key,
    required this.name,
    required this.value,
    required this.onChanged,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  final String name;
  final bool value;
  final void Function(bool value) onChanged;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(name),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
