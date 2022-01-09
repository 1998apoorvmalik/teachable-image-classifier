import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachable_image_classifier/models/models.dart';
import 'package:teachable_image_classifier/screens/classification_train/cubit/object_classification_cubit.dart';
import 'package:teachable_image_classifier/screens/classification_train/widgets/widgets.dart';
import 'package:teachable_image_classifier/widgets/widgets.dart';

class ClassificationTrain extends StatelessWidget {
  const ClassificationTrain({Key? key}) : super(key: key);

  static const String routeName = "/classification-train";

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) {
        return BlocProvider<ClassificationCubit>(
          create: (_) => ClassificationCubit(),
          child: ClassificationTrain(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Classification Model'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<ClassificationCubit, ClassificationState>(
          listener: (BuildContext context, ClassificationState state) {
            if (state.status == ClassificationStateStatus.error) {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ErrorDialog(content: state.failure.message),
              ).then((_) {
                context
                    .read<ClassificationCubit>()
                    .onLog(log: '[ERROR] Model training terminated.');
              });
            }
          },
          builder: (BuildContext context, ClassificationState state) {
            String _getConsoleText() {
              StringBuffer sb = new StringBuffer();
              for (String line in state.logs) {
                sb.write(line + "\n");
              }
              return sb.toString();
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: state.classes
                          .map(
                            (ObjectClassificationClass
                                    objectClassificationClass) =>
                                Card(
                              child: ClassConfigCard(
                                objectClassificationClass:
                                    objectClassificationClass,
                              ),
                            ),
                          )
                          .toList()
                        ..add(
                          Card(
                            child: OutlinedButton(
                              onPressed: () => context
                                  .read<ClassificationCubit>()
                                  .addClass(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 36.0),
                                child: Center(
                                  child: Text('Add a Class'),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        if (state.status == ClassificationStateStatus.loading)
                          LinearProgressIndicator(),
                        TrainingConsole(
                          state: state,
                        ),
                        Expanded(
                          flex: 1,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white24, width: 2),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Terminal',
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                          InkWell(
                                            child: Icon(Icons.clear),
                                            onTap: () {
                                              context
                                                  .read<ClassificationCubit>()
                                                  .clearLog();
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white24,
                                      height: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        color: Colors.black,
                                        child: Column(
                                          mainAxisAlignment: state.logs.isEmpty
                                              ? MainAxisAlignment.center
                                              : MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                state.logs.isEmpty
                                                    ? 'Start training to show logs'
                                                    : _getConsoleText(),
                                                textAlign: state.logs.isEmpty
                                                    ? TextAlign.center
                                                    : TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
