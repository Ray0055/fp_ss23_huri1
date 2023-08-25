import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/functions/QuestionsCard.dart';
import 'package:logic_app/providers/Providers.dart';

class QuestionCardWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<QuestionCard?>(
      future: ref.read(dataBaseProvider).getQuestionById(0), // your Future function here
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
                    Text(
                      currentQuestion.question,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                            // Fetch and set last question
                          },
                          child: Text("Last"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Fetch and set next question
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
