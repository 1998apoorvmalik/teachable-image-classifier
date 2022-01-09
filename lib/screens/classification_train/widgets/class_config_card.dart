import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:teachable_image_classifier/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachable_image_classifier/screens/classification_train/cubit/object_classification_cubit.dart';
import 'package:teachable_image_classifier/screens/classification_train/widgets/widgets.dart';

class ClassConfigCard extends StatefulWidget {
  const ClassConfigCard({
    Key? key,
    required this.objectClassificationClass,
  }) : super(key: key);

  final ObjectClassificationClass objectClassificationClass;

  @override
  _ClassConfigCardState createState() => _ClassConfigCardState();
}

class _ClassConfigCardState extends State<ClassConfigCard> {
  late final TextEditingController _editingController;
  late int _classIndex;
  bool _isEditingText = false;

  @override
  void initState() {
    _editingController =
        TextEditingController(text: widget.objectClassificationClass.className);

    _classIndex = context
        .read<ClassificationCubit>()
        .state
        .classes
        .indexWhere((element) => element == widget.objectClassificationClass);

    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  Widget _editTitleTextField() {
    if (_isEditingText) {
      return Flexible(
        child: Center(
          child: TextField(
            maxLength: 32,
            onSubmitted: (newValue) {
              setState(() {
                context.read<ClassificationCubit>().changeClassName(
                    classIndex: _classIndex, newClassName: newValue);
                _isEditingText = false;
              });
            },
            autofocus: true,
            controller: _editingController,
          ),
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Text(
        widget.objectClassificationClass.className,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  SizedBox(
                    width: 8.0,
                  ),
                  _editTitleTextField(),
                  IconButton(
                    onPressed: () => setState(() {
                      context.read<ClassificationCubit>().changeClassName(
                          classIndex: _classIndex,
                          newClassName: _editingController.text);
                      _isEditingText = !_isEditingText;
                    }),
                    icon: Icon(
                      _isEditingText ? Icons.done : Icons.edit,
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!widget.objectClassificationClass.isEnabled)
                    Text(
                      'Class Disabled',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  SizedBox(
                    width: 12.0,
                  ),
                  PopupMenuButton<VoidCallback>(
                    onSelected: (VoidCallback callback) => callback(),
                    itemBuilder: (_) => [
                      PopupMenuItem<VoidCallback>(
                          value: () {
                            context
                                .read<ClassificationCubit>()
                                .deleteClass(_classIndex);
                          },
                          child: Text('Delete Class')),
                      PopupMenuItem<VoidCallback>(
                          value: () => context
                              .read<ClassificationCubit>()
                              .toggleEnable(_classIndex),
                          child: Text(widget.objectClassificationClass.isEnabled
                              ? 'Disable Class'
                              : 'Enable Class')),
                      PopupMenuItem<VoidCallback>(
                          value: () => context
                              .read<ClassificationCubit>()
                              .clearSamples(_classIndex),
                          child: Text('Clear all Samples')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Image Samples:',
              ),
              if (widget.objectClassificationClass.samples.isNotEmpty)
                Text(
                    '${widget.objectClassificationClass.samples.length} Image Samples')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => {},
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
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'jpeg', 'png', 'heic'],
                        );

                        if (result != null) {
                          List<File> files =
                              result.paths.map((path) => File(path!)).toList();

                          context
                              .read<ClassificationCubit>()
                              .addFiles(classIndex: _classIndex, files: files);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.upload),
                            Text('Upload'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: widget.objectClassificationClass.samples
                        .map(
                          (File imageFile) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: SampleImage(
                              onDeletePressed: () => context
                                  .read<ClassificationCubit>()
                                  .deleteSample(
                                    classIndex: _classIndex,
                                    imageFile: imageFile,
                                  ),
                              imageFile: imageFile,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
