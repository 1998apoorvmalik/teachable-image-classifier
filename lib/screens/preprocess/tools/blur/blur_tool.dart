import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachable_image_classifier/enums.dart';
import 'package:teachable_image_classifier/config/extensions.dart';
import 'package:teachable_image_classifier/screens/preprocess/tools/tools.dart';
import 'package:teachable_image_classifier/widgets/widgets.dart';

class BlurTool extends StatelessWidget {
  const BlurTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlurCubit, BlurState>(
      builder: (BuildContext context, BlurState state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToolSwitch(
                name: 'Enabled',
                value: state.enabled,
                onChanged: (_) => context.read<BlurCubit>().toogleEnable(),
              ),
              ToolRadioSelector<BlurType>(
                label: 'Blur Type',
                defaultIndex: state.blurType.index,
                values: BlurType.values,
                processLabel: (BlurType value) =>
                    value.toString().split('.').last.capitalize(),
                onChanged: (BlurType blurType) {
                  context.read<BlurCubit>().changeBlurType(blurType);
                },
              ),
              if (state.blurType != BlurType.bilateralFiltering)
                ToolSlider(
                  name: 'Aperture Linear Size',
                  value: state.kSize.toDouble(),
                  onChanged: (double value) {
                    context
                        .read<BlurCubit>()
                        .changeApertureLinearSize(value.toInt());
                  },
                ),
              if (state.blurType == BlurType.gaussian)
                ToolSlider(
                  name: 'Sigma X',
                  value: state.sigmaX,
                  onChanged: (double value) {
                    context.read<BlurCubit>().changeSigmaX(value);
                  },
                ),
              if (state.blurType == BlurType.gaussian)
                ToolSlider(
                  name: 'Sigma Y',
                  value: state.sigmaY,
                  onChanged: (double value) {
                    context.read<BlurCubit>().changeSigmaY(value);
                  },
                ),
              if (state.blurType == BlurType.bilateralFiltering)
                ToolSlider(
                  name: 'Diameter',
                  value: state.diameter.toDouble(),
                  onChanged: (double value) {
                    context.read<BlurCubit>().changeDiameter(value.toInt());
                  },
                ),
              if (state.blurType == BlurType.bilateralFiltering)
                ToolSlider(
                  name: 'Sigma Color',
                  value: state.sigmaColor,
                  onChanged: (double value) {
                    context.read<BlurCubit>().changeSigmaColor(value);
                  },
                ),
              if (state.blurType == BlurType.bilateralFiltering)
                ToolSlider(
                  name: 'Sigma Space',
                  value: state.sigmaSpace,
                  onChanged: (double value) {
                    context.read<BlurCubit>().changeSigmaSpace(value);
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
