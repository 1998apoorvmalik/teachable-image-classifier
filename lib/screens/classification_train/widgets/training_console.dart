import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:teachable_image_classifier/enums.dart';
import 'package:teachable_image_classifier/screens/classification_train/cubit/object_classification_cubit.dart';
import 'package:teachable_image_classifier/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingConsole extends StatelessWidget {
  const TrainingConsole({
    Key? key,
    required this.state,
  }) : super(key: key);

  final ClassificationState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Training',
                style: TextStyle(fontSize: 24),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Export Model'),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  ElevatedButton(
                      onPressed: () => context
                          .read<ClassificationCubit>()
                          .train(context: context),
                      child: Text('Train Model')),
                  SizedBox(
                    width: 8.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Scaffold.of(context).showBottomSheet((context) =>
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                      height: 100,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_alt),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            'Camera',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                      height: 100,
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          allowMultiple: false,
                                          type: FileType.custom,
                                          allowedExtensions: [
                                            'jpg',
                                            'jpeg',
                                            'png',
                                            'heic'
                                          ],
                                        );

                                        if (result != null) {
                                          List<File> files = result.paths
                                              .map((path) => File(path!))
                                              .toList();

                                          context
                                              .read<ClassificationCubit>()
                                              .predict(
                                                  context: context,
                                                  file: files.first);
                                        }

                                        Navigator.of(context).pop();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.upload),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text('Upload',
                                              style: TextStyle(fontSize: 18)),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ));
                    },
                    child: Text('Run Model'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Data Augmentation',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.info_outline),
                  ),
                  SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.restore),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: ToolSwitch(
                name: 'Enabled',
                value: state.augEnabled,
                onChanged: (_) =>
                    context.read<ClassificationCubit>().toggleEnableAug(),
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Iterations'),
                  SizedBox(width: 8.0),
                  IncDecNumField(
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Batch Size'),
                  SizedBox(width: 8.0),
                  IncDecNumField(
                      defaultValue: state.augBatchSize,
                      onChanged: (int newValue) => context
                          .read<ClassificationCubit>()
                          .changeAugBatchSize(newValue)),
                ],
              ),
            )
          ],
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Model Parameters',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.info_outline),
                  ),
                  SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.restore),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            children: [
              Text('Base Model'),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.white24,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, top: 5, bottom: 5),
                  child: DropdownButton<ClassificationBaseModel>(
                    onChanged:
                        (ClassificationBaseModel? classificationBaseModel) {
                      context
                          .read<ClassificationCubit>()
                          .changeBaseModel(classificationBaseModel!);
                    },
                    isDense: true,
                    iconSize: 18,
                    underline: Container(),
                    value: state.baseModel,
                    items: ClassificationBaseModel.values
                        .map<DropdownMenuItem<ClassificationBaseModel>>(
                            (ClassificationBaseModel classificationBaseModel) =>
                                DropdownMenuItem<ClassificationBaseModel>(
                                  value: classificationBaseModel,
                                  child: Text(classificationBaseModel
                                      .toString()
                                      .split('.')
                                      .last),
                                ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text('Loss Function'),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.white24,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, top: 5, bottom: 5),
                  child: DropdownButton<ModelLossFunction>(
                    onChanged: (ModelLossFunction? modelLossFunction) {
                      context
                          .read<ClassificationCubit>()
                          .changeLossFunction(modelLossFunction!);
                    },
                    isDense: true,
                    iconSize: 18,
                    underline: Container(),
                    value: state.lossFunction,
                    items: ModelLossFunction.values
                        .map<DropdownMenuItem<ModelLossFunction>>(
                            (ModelLossFunction modelLossFunction) =>
                                DropdownMenuItem<ModelLossFunction>(
                                  value: modelLossFunction,
                                  child: Text(modelLossFunction
                                      .toString()
                                      .split('.')
                                      .last),
                                ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text('Optimizer'),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.white24,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, top: 5, bottom: 5),
                  child: DropdownButton<ModelOptimizer>(
                    onChanged: (ModelOptimizer? modelOptimizer) {
                      context
                          .read<ClassificationCubit>()
                          .changeOptimizer(modelOptimizer!);
                    },
                    isDense: true,
                    iconSize: 18,
                    underline: Container(),
                    value: state.modelOptimizer,
                    items: ModelOptimizer.values
                        .map<DropdownMenuItem<ModelOptimizer>>(
                            (ModelOptimizer modelOptimizer) =>
                                DropdownMenuItem<ModelOptimizer>(
                                  value: modelOptimizer,
                                  child: Text(modelOptimizer
                                      .toString()
                                      .split('.')
                                      .last),
                                ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ]),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Training Parameters',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.info_outline),
                  ),
                  SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.restore),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Epochs'),
                  SizedBox(width: 8.0),
                  IncDecNumField(
                      defaultValue: state.epochs,
                      onChanged: (int newValue) => context
                          .read<ClassificationCubit>()
                          .changeEpochs(newValue)),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Batch Size'),
                  SizedBox(width: 8.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.white24,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 4, top: 5, bottom: 5),
                      child: DropdownButton<int>(
                        isDense: true,
                        value: state.trainBatchSize,
                        icon: Row(
                          children: [
                            Container(
                              width: 1,
                              height: double.infinity,
                              color: Colors.white24,
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        iconSize: 18,
                        underline: Container(),
                        onChanged: (int? newValue) => context
                            .read<ClassificationCubit>()
                            .changeTrainingBatchSize(newValue!),
                        items: <int>[
                          16,
                          32,
                          64,
                          128,
                          256,
                          512,
                        ].map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                value.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Learning Rate'),
                  SizedBox(width: 8.0),
                  IncDecNumField(
                      defaultValue: state.learningRate,
                      onChanged: (int newValue) => context
                          .read<ClassificationCubit>()
                          .changeLearningRate(newValue)),
                ],
              ),
            )
          ],
        ),
        Divider(),
      ],
    );
  }
}
