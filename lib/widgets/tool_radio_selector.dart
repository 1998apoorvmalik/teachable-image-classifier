import 'package:flutter/material.dart';

class ToolRadioSelector<T> extends StatefulWidget {
  const ToolRadioSelector({
    Key? key,
    required this.label,
    required this.values,
    this.onChanged,
    this.processLabel,
    this.defaultIndex = 0,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  }) : super(key: key);

  final String label;
  final List<T> values;
  final int defaultIndex;
  final void Function(T value)? onChanged;
  final String Function(T value)? processLabel;
  final MainAxisAlignment mainAxisAlignment;

  @override
  _ToolRadioSelectorState<T> createState() => _ToolRadioSelectorState<T>();
}

class _ToolRadioSelectorState<T> extends State<ToolRadioSelector<T>> {
  late T selectedValue = widget.values[widget.defaultIndex];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.label),
        Flexible(
          child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: widget.values
                .map(
                  (T element) => Column(
                    children: [
                      Text(widget.processLabel != null
                          ? widget.processLabel!(element)
                          : element.toString()),
                      Radio<T>(
                          value: element,
                          groupValue: selectedValue,
                          onChanged: (T? value) {
                            if (value != null) {
                              if (widget.onChanged != null) {
                                widget.onChanged!(value);
                              }
                              setState(() {
                                selectedValue = value;
                              });
                            }
                          }),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
