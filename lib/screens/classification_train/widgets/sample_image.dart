import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

class SampleImage extends StatefulWidget {
  const SampleImage(
      {Key? key,
      required this.imageFile,
      required this.onDeletePressed,
      this.previewSize = 50,
      this.blurSigma = 3})
      : super(key: key);

  final File imageFile;
  final VoidCallback onDeletePressed;
  final double previewSize;
  final double blurSigma;

  @override
  _SampleImageState createState() => _SampleImageState();
}

class _SampleImageState extends State<SampleImage> {
  bool _showDeleteButton = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _showDeleteButton = true;
        });
      },
      onExit: (_) {
        setState(() {
          _showDeleteButton = false;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.file(
            widget.imageFile,
            fit: BoxFit.cover,
            height: widget.previewSize,
            width: widget.previewSize,
          ),
          if (_showDeleteButton)
            ClipRect(
              clipBehavior: Clip.hardEdge,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.blurSigma,
                  sigmaY: widget.blurSigma,
                ),
                child: Container(
                  height: widget.previewSize,
                  width: widget.previewSize,
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDeletePressed,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
