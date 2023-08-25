import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/Providers.dart';
import 'package:logic_app/widgets/QuestionWidget.dart';
import 'package:logic_app/functions/QuestionsCard.dart';
class QuizPage extends ConsumerWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double kDefaultPadding = 20.0;
    QuestionCard questionCard = new QuestionCard(id: 0, question: "What is logic", options: ["A", "B","C","D"], correctIndex: 0, createdTime: "createdTime", modifiedTime: "modifiedTime");
    return Scaffold(
      appBar: AppBar(
        title: Text("Number"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.list),
        ),
      ),
      body: Column(children: [
        QuestionCardWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text.rich(
            TextSpan(
              text: "Question 1",
              children: [TextSpan(text: "/10")],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: (){
          ref.watch(dataBaseProvider).addQuestions(questionCard);
          },
            child: Text("add")),
        ElevatedButton(
            onPressed: (){
              ref.watch(dataBaseProvider).clearTable();
            },
            child: Text("clear table"))
      ]),
    );
  }
}
