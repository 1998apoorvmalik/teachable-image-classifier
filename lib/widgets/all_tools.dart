import 'package:flutter/material.dart';
import 'package:teachable_image_classifier/config/extensions.dart';
import 'package:teachable_image_classifier/enums.dart';

class AllTools extends StatelessWidget {
  const AllTools({Key? key, required this.onPressed, this.selectedTool})
      : super(key: key);

  final void Function(PreprocessTool tool) onPressed;
  final PreprocessTool? selectedTool;

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [];

    PreprocessTool.values.forEach(
      (PreprocessTool tool) {
        buttons.add(
          Expanded(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: tool == selectedTool
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.surface,
              child: Text(tool.toString().split('.').last.capitalize()),
              onPressed: () => onPressed(tool),
            ),
          ),
        );
      },
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttons,
    );
  }
}
