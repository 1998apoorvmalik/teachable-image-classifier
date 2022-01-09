import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:teachable_image_classifier/enums.dart';
import 'package:teachable_image_classifier/screens/preprocess/cubit/preprocess_cubit.dart';
import 'package:teachable_image_classifier/screens/preprocess/tools/tools.dart';
import 'package:teachable_image_classifier/widgets/widgets.dart';

class PreprocessScreen extends StatefulWidget {
  static const String routeName = "/preprocess";

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<PreprocessCubit>(
              create: (BuildContext context) => PreprocessCubit(),
            ),
            BlocProvider<BlurCubit>(
              create: (BuildContext context) => BlurCubit(),
            ),
            BlocProvider<ThresholdCubit>(
              create: (BuildContext context) => ThresholdCubit(),
            ),
            BlocProvider<EdgeDetectorCubit>(
              create: (BuildContext context) => EdgeDetectorCubit(),
            ),
          ],
          child: PreprocessScreen(),
        );
      },
    );
  }

  @override
  _PreprocessScreenState createState() => _PreprocessScreenState();
}

class _PreprocessScreenState extends State<PreprocessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text('Preprocess Screen'),
        actions: [
          TextButton(
              onPressed: () =>
                  context.read<PreprocessCubit>().preprocess(context: context),
              child: Text('Preprocess'))
        ],
      ),
      body: BlocBuilder<PreprocessCubit, PreprocessState>(
        builder: (BuildContext context, PreprocessState state) {
          late final Widget optionPanelDisplay;

          switch (state.selectedTool) {
            case PreprocessTool.crop:
              optionPanelDisplay = CropTool();
              break;
            case PreprocessTool.adjuster:
              optionPanelDisplay = AdjusterTool();
              break;
            case PreprocessTool.blur:
              optionPanelDisplay = BlurTool();
              break;
            case PreprocessTool.threshold:
              optionPanelDisplay = ThresholdTool();
              break;
            case PreprocessTool.edgeDetector:
              optionPanelDisplay = EdgeDetectorTool();
              break;
            case null:
              optionPanelDisplay = Text(
                'Select an Option from the left panel.',
              );
              break;
          }

          final double _imageFrameSize = MediaQuery.of(context).size.height / 2;

          Image? image;

          if (state.processedImagePath != null &&
              state.processedImagePath!.isNotEmpty) {
            print(1);
            image = Image.memory(
              File(state.processedImagePath!).readAsBytesSync(),
              gaplessPlayback: true,
            );
          }

          return Column(
            children: [
              SizedBox(
                height: 60,
                child: AllTools(
                  onPressed: (PreprocessTool tool) =>
                      context.read<PreprocessCubit>().changeSelectedTool(tool),
                  selectedTool: state.selectedTool,
                ),
              ),
              Container(
                child: optionPanelDisplay,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Image frame
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: _imageFrameSize,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 24.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Image Preview',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.replay_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  onTap: () => context
                                      .read<PreprocessCubit>()
                                      .resetImage(),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: _imageFrameSize,
                            width: _imageFrameSize,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: image != null
                                ? PhotoView(
                                    imageProvider: image.image,
                                    maxScale: 0.5,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Load an image',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                      SizedBox(height: 8),
                                      ImageLoader(
                                        onCameraTap: () {},
                                        onUploadTap: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: [
                                              'jpg',
                                              'jpeg',
                                              'png',
                                              'heic'
                                            ],
                                          );

                                          if (result != null &&
                                              result.paths.first != null &&
                                              result.paths.first!.isNotEmpty) {
                                            context
                                                .read<PreprocessCubit>()
                                                .loadImage(result.paths.first!);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
