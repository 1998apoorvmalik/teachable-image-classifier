import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachable_image_classifier/enums.dart';
import 'package:teachable_image_classifier/config/extensions.dart';
import 'package:teachable_image_classifier/screens/preprocess/tools/tools.dart';
import 'package:teachable_image_classifier/widgets/widgets.dart';

class EdgeDetectorTool extends StatelessWidget {
  const EdgeDetectorTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EdgeDetectorCubit, EdgeDetectorState>(
      builder: (BuildContext context, EdgeDetectorState state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToolSwitch(
                name: 'Enabled',
                value: state.enabled,
                onChanged: (_) =>
                    context.read<EdgeDetectorCubit>().toogleEnable(),
              ),
              ToolRadioSelector<EdgeDetectorType>(
                label: 'Edge Detector Type',
                defaultIndex: state.edgeDetectorType.index,
                values: EdgeDetectorType.values,
                processLabel: (EdgeDetectorType value) =>
                    value.toString().split('.').last.capitalize(),
                onChanged: (EdgeDetectorType edgeDetectorType) {
                  context
                      .read<EdgeDetectorCubit>()
                      .changeEdgeDetectorType(edgeDetectorType);
                },
              ),
              ToolSlider(
                name: 'Lower Threshold',
                value: state.threshold1,
                onChanged: (double value) {
                  context.read<EdgeDetectorCubit>().changeThreshold1(value);
                },
              ),
              ToolSlider(
                name: 'Upper Threshold',
                value: state.threshold2,
                onChanged: (double value) {
                  context.read<EdgeDetectorCubit>().changeThreshold2(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
