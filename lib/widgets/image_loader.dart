import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key? key,
    this.onCameraTap,
    this.onUploadTap,
    this.mainAxisAlignment: MainAxisAlignment.center,
  }) : super(key: key);

  final VoidCallback? onCameraTap;
  final VoidCallback? onUploadTap;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        ElevatedButton(
          onPressed: onCameraTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera_alt),
                Text('Camera'),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        ElevatedButton(
          onPressed: onUploadTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.upload),
                Text('Upload'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
