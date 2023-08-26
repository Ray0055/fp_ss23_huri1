import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:logic_app/functions/QuestionsCard.dart';
import 'package:logic_app/providers/Providers.dart';


class QuestionCardWidget extends ConsumerWidget {
  const QuestionCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(questionIndexProvider);
    return FutureBuilder<QuestionCard?>(
      future: ref.watch(dataBaseProvider).getQuestionById(index),
      // your Future function here
      builder: (BuildContext context, AsyncSnapshot<QuestionCard?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Your main Widget here
          final currentQuestion = snapshot.data;
          if (currentQuestion != null) {
            return Card(
              elevation: 5.0,
              margin: EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TeXView(
                        renderingEngine: const TeXViewRenderingEngine.katex(),
                        child: TeXViewDocument(currentQuestion.question)),
                    SizedBox(height: 20),
                    for (var i = 0; i < currentQuestion.options.length; i++)
                      ListTile(
                        title: Text(currentQuestion.options[i]),
                        // Add your onTap logic here
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ref.read(questionIndexProvider.notifier).state--;
                          },
                          child: Text("Last"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(questionIndexProvider.notifier).state++;
                            if (ref.read(questionIndexProvider.notifier).state > 3){
                              ref.read(questionIndexProvider.notifier).state=1;
                            }
                          },
                          child: Text("Next"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text("No question found");
          }
        }
      },
    );
  }
}
