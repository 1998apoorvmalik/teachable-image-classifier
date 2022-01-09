import 'package:flutter/material.dart';

class ToolSlider extends StatelessWidget {
  const ToolSlider({
    Key? key,
    required this.name,
    required this.value,
    required this.onChanged,
    this.minVal = 0,
    this.maxVal = 255,
  }) : super(key: key);

  final String name;
  final double value;
  final void Function(double value) onChanged;
  final double minVal;
  final double maxVal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Flexible(
          child: Slider(
            value: value,
            min: minVal,
            max: maxVal,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            value.round().toString(),
          ),
        ),
      ],
    );
  }
}
