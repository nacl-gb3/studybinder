import 'package:flutter/material.dart';
import 'instance.dart';
import 'question.dart';

class MyQuestionPage extends StatefulWidget {
  const MyQuestionPage({super.key, required this.title});

  final String title;

  @override
  State<MyQuestionPage> createState() => _MyQuestionPageState();

}

class _MyQuestionPageState extends State<MyQuestionPage> {
	Question? activeQuestion;

	@override
	void initState() {
		activeQuestion = Question();
		activeQuestion!.examSemester = "Fall 2023";
		activeQuestion!.examUnit = 2;
		activeQuestion!.questionNum = 1;
		activeQuestion!.type = "Multiple Choice";
		activeQuestion!.given = "memes";
		activeQuestion!.explanation = "no memes";
		activeQuestion!.answer = "please";
		activeQuestion!.possibleAnswers = ["please", "yes", "no", "get out of my house"];
		super.initState();
	}

	@override
	void dispose() {
		activeQuestion = null;
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
		appBar: AppBar(
			backgroundColor: Theme.of(context).colorScheme.inversePrimary,
			title: Text("${activeQuestion!.examSemester}, Exam ${activeQuestion!.examUnit}, "
				+ "Q${activeQuestion!.questionNum}"),
		),
		body: Center(
			child: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				const Text(
				"Not ready for you yet, but go ahead and press the button since you came:",
				),
				Text(
				'memes',
				style: Theme.of(context).textTheme.headlineMedium,
				),
			],
			),
		),
		floatingActionButton: FloatingActionButton(
			onPressed: () => {},
			tooltip: 'Increment',
			child: const Icon(Icons.add),
		), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
}
