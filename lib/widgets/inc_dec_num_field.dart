import 'package:flutter/material.dart';

class IncDecNumField extends StatefulWidget {
  const IncDecNumField({
    Key? key,
    required this.onChanged,
    this.defaultValue = 32,
    this.minValue = 0,
    this.maxValue = 4096,
    this.borderColor = Colors.white24,
    this.iconColor = Colors.white,
  }) : super(key: key);

  final Function(int) onChanged;
  final int defaultValue;
  final int minValue;
  final int maxValue;
  final Color borderColor;
  final Color iconColor;

  @override
  _IncDecNumFieldState createState() => _IncDecNumFieldState();
}

class _IncDecNumFieldState extends State<IncDecNumField> {
  late final TextEditingController _numFieldController;

  @override
  void initState() {
    _numFieldController =
        TextEditingController(text: widget.defaultValue.toString());
    super.initState();
  }

  @override
  void dispose() {
    _numFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      height: 36,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: widget.borderColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: TextField(
                  maxLength: 4,
                  controller: _numFieldController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  onEditingComplete: () {
                    int? newValue = int.tryParse(_numFieldController.text);
                    if (_numFieldController.text.isEmpty) {
                      _numFieldController.text = widget.minValue.toString();
                    } else if (newValue == null) {
                      _numFieldController.text = widget.defaultValue.toString();
                    } else if (newValue >= widget.maxValue) {
                      _numFieldController.text = widget.maxValue.toString();
                    } else if (newValue <= widget.minValue) {
                      _numFieldController.text = widget.minValue.toString();
                    } else {
                      _numFieldController.text = newValue.toString();
                    }
                    widget.onChanged(int.parse(_numFieldController.text));
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            Container(
              height: 32,
              width: 1,
              color: widget.borderColor,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      int value = int.parse(_numFieldController.text);
                      if (value >= widget.maxValue) {
                        _numFieldController.text = widget.maxValue.toString();
                      } else {
                        _numFieldController.text = (value + 1).toString();
                      }
                      widget.onChanged(int.parse(_numFieldController.text));
                    },
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 16,
                    ),
                  ),
                  Container(
                    height: 1,
                    color: widget.borderColor,
                  ),
                  InkWell(
                    onTap: () {
                      int value = int.parse(_numFieldController.text);
                      if (value <= widget.minValue) {
                        _numFieldController.text = widget.minValue.toString();
                      } else {
                        _numFieldController.text = (value - 1).toString();
                      }
                      widget.onChanged(int.parse(_numFieldController.text));
                    },
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
