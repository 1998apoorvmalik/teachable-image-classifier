import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachable_image_classifier/enums.dart';
import 'package:teachable_image_classifier/config/extensions.dart';
import 'package:teachable_image_classifier/screens/preprocess/tools/threshold/cubit/threshold_cubit.dart';
import 'package:teachable_image_classifier/widgets/widgets.dart';

class ThresholdTool extends StatelessWidget {
  const ThresholdTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThresholdCubit, ThresholdState>(
      builder: (BuildContext context, ThresholdState state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToolSwitch(
                    name: 'Enabled',
                    value: state.enabled,
                    onChanged: (_) =>
                        context.read<ThresholdCubit>().toogleEnable(),
                  ),
                  if (state.thresholdCategory == ThresholdCategory.simple)
                    Row(
                      children: [
                        ToolSwitch(
                            name: 'Use Otsu',
                            value: state.useOtsu,
                            onChanged: (_) =>
                                context.read<ThresholdCubit>().toggleUseOtsu())
                      ],
                    ),
                  if (state.thresholdCategory == ThresholdCategory.adaptive)
                    Row(
                      children: [
                        Text('Adaptive Method'),
                        SizedBox(width: 12),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<AdaptiveThresholdMethod>(
                            onChanged: (AdaptiveThresholdMethod?
                                adaptiveThresholdMethod) {
                              if (adaptiveThresholdMethod != null) {
                                context
                                    .read<ThresholdCubit>()
                                    .changeAdaptiveThresholdMethod(
                                        adaptiveThresholdMethod);
                              }
                            },
                            isDense: true,
                            value: state.adaptiveThresholdMethod,
                            items: AdaptiveThresholdMethod.values
                                .map<DropdownMenuItem<AdaptiveThresholdMethod>>(
                                    (AdaptiveThresholdMethod
                                            adaptiveThresholdMethod) =>
                                        DropdownMenuItem<
                                            AdaptiveThresholdMethod>(
                                          value: adaptiveThresholdMethod,
                                          child: Text(adaptiveThresholdMethod
                                              .toString()
                                              .split('.')
                                              .last
                                              .capitalize()),
                                        ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Text('Threshold Category'),
                      SizedBox(width: 12),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<ThresholdCategory>(
                          onChanged: (ThresholdCategory? thresholdCategory) {
                            if (thresholdCategory != null) {
                              context
                                  .read<ThresholdCubit>()
                                  .changeThresholdCategory(thresholdCategory);
                            }
                          },
                          isDense: true,
                          value: state.thresholdCategory,
                          items: ThresholdCategory.values
                              .map<DropdownMenuItem<ThresholdCategory>>(
                                  (ThresholdCategory thresholdCategory) =>
                                      DropdownMenuItem<ThresholdCategory>(
                                        value: thresholdCategory,
                                        child: Text(thresholdCategory
                                            .toString()
                                            .split('.')
                                            .last
                                            .capitalize()),
                                      ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ToolRadioSelector<ThresholdType>(
                label: 'Threshold Type',
                defaultIndex: state.thresholdType.index,
                values: ThresholdType.values,
                processLabel: (ThresholdType value) =>
                    value.toString().split('.').last.capitalize(),
                onChanged: (ThresholdType thresholdType) {
                  context
                      .read<ThresholdCubit>()
                      .changeThresholdType(thresholdType);
                },
              ),
              if (state.thresholdCategory == ThresholdCategory.simple)
                ToolSlider(
                  name: 'Lower Thresh Value',
                  value: state.lowerThreshValue,
                  onChanged: (double value) {
                    context
                        .read<ThresholdCubit>()
                        .changeLowerThreshValue(value);
                  },
                ),
              if (state.thresholdCategory == ThresholdCategory.simple)
                ToolSlider(
                  name: 'Upper Thresh Value',
                  value: state.upperThreshValue,
                  onChanged: (double value) {
                    context
                        .read<ThresholdCubit>()
                        .changeUpperThreshValue(value);
                  },
                ),
              if (state.thresholdCategory == ThresholdCategory.adaptive)
                ToolSlider(
                  name: 'Max Value',
                  value: state.maxValue,
                  onChanged: (double value) {
                    context.read<ThresholdCubit>().changeMaxValue(value);
                  },
                ),
              if (state.thresholdCategory == ThresholdCategory.adaptive)
                ToolSlider(
                    name: 'Block Size',
                    value: state.blockSize.toDouble(),
                    minVal: 1,
                    maxVal: 50,
                    onChanged: (double value) {
                      context
                          .read<ThresholdCubit>()
                          .changeBlockSize(value.toInt());
                    }),
              if (state.thresholdCategory == ThresholdCategory.adaptive)
                ToolSlider(
                    name: 'Constant C',
                    value: state.constantC.toDouble(),
                    minVal: -50,
                    maxVal: 50,
                    onChanged: (double value) {
                      context.read<ThresholdCubit>().changeConstantC(value);
                    }),
            ],
          ),
        );
      },
    );
  }
}
