import 'package:flutter/material.dart';
import '../instance.dart';

class MyQuestionPage extends StatefulWidget {
  const MyQuestionPage({super.key, required this.title});

  final String title;

  @override
  State<MyQuestionPage> createState() => _MyQuestionPageState();

}

class _MyQuestionPageState extends State<MyQuestionPage> {
	bool questionActive = false;
	List<String>? answerList;
	int guesses = 0;
	bool answerCorrect = false;
	TextEditingController textController = TextEditingController();

	final List<Color> _colors = <Color>[
		Colors.blue,
		Colors.green,
		Colors.red
	];

	final Map<String, int> _currentColorIndex = {};
	int currentColorIndex = 0;

	@override
	void initState() {
		super.initState();
	}

	Future<bool> initQuestion() async {
		if (questionActive) {
			return true;
		}

		await Instance.setRandomQuestion();

		for (String answer in Instance.activeQuestion!.possibleAnswers) {
			_currentColorIndex[answer] = 0;
		}

		if (Instance.activeQuestion!.type == "Multiple Choice") {
			answerList = Instance.activeQuestion!.shuffleAnswers();
		}
		else if (Instance.activeQuestion!.type == "True/False") {
			answerList = Instance.activeQuestion!.possibleAnswers;
		}
		else {
			answerList = [""];
		}

		questionActive = true;
		return questionActive;
	}

	@override
	void dispose() {
		Instance.activeQuestion = null;
		_currentColorIndex.clear();
		answerList = null;
		answerCorrect = false;
		questionActive = false;
		super.dispose();
	}

	void _checkAnswer(String chosenOption) {
		guesses++;

		if (answerCorrect) {
			return;
		}

		if (Instance.activeQuestion!.type != "Free Response") {
			answerCorrect = chosenOption == Instance.activeQuestion!.answer;

			if (Instance.activeQuestion!.type == "Multiple Choice" 
				|| Instance.activeQuestion!.type == "True/False") {
				setState( () {
					if (answerCorrect) {
						_currentColorIndex[chosenOption] = 1;
					}
					else {
						_currentColorIndex[chosenOption] = 2;	
						if (guesses >= answerList!.length - 1) {
							_currentColorIndex[Instance.activeQuestion!.answer] = 1;
							answerCorrect = true;
						}
					}

				});
			}
			else {
				setState( () {
					if (answerCorrect) {
						currentColorIndex = 1;
					}
					else {
						currentColorIndex = 2;
						if (guesses >= answerList!.length - 1) {
							answerCorrect = true;
						}
					}
				});
			}

			if (answerCorrect || guesses >= answerList!.length - 1) {
				displayExplanation("Answer: ${Instance.activeQuestion!.answer}");
			}
		}

		else {
			displayExplanation("Read the below explanation");
		}

	}

	void displayExplanation(String header) {
		showDialog(
			context: context, 
			builder: (_) => AlertDialog(
				title: Text(header),
				content: Text(Instance.activeQuestion!.explanation),
				actions: [TextButton(onPressed: () {Navigator.pop(context);}, child: const Text("OK"))],
			),
			barrierDismissible: false,
		);
	}

	Widget displayAnswerContainer(String option) {
		if (Instance.activeQuestion!.type == "Free Response") {
			return Container( 
				color: Colors.white,
				width: 400,
				height: 200,
				child: Column(
					children: <Widget>[
						Padding(
							padding: const EdgeInsets.all(15.0),
							child: SingleChildScrollView(
								scrollDirection: Axis.vertical,
								child: TextField(
									controller: textController,
									maxLines: 4,	
								),
							),
						),
						ElevatedButton(
							style: ElevatedButton.styleFrom(
								backgroundColor: Colors.blue,
								minimumSize: const Size(300, 60),
							),
							onPressed: () => {
								if (textController.text.isNotEmpty) {
									_checkAnswer(textController.text)
								}
							}, 
							child: const Text(
								"Submit answer",
								style: TextStyle(
									color: Colors.white,
								),
							),
						),
					],
				),
			);

		}

		if (Instance.activeQuestion!.type == "Short Answer") {
			return Container( 
				color: Colors.white,
				width: 400,
				height: 200,
				child: Column(
					children: <Widget>[
						Padding(
							padding: const EdgeInsets.all(15.0),
							child: TextField(
								controller: textController,
								maxLines: 1,	
							),
						),
						ElevatedButton(
							style: ElevatedButton.styleFrom(
								backgroundColor: _colors[currentColorIndex],
								minimumSize: const Size(300, 60),
							),
							onPressed: () => {
								if (textController.text.isNotEmpty) {
									_checkAnswer(textController.text)
								}
							}, 
							child: const Text(
								"Submit answer",
								style: TextStyle(
									color: Colors.white,
								),
							),
						),
					],
				),
			);
		}
		
		return Container(
			margin: const EdgeInsets.all(10),
			child: ElevatedButton(
				style: ElevatedButton.styleFrom(
					backgroundColor: _colors[_currentColorIndex[option]!],
					minimumSize: const Size(300, 60),
				),
				child: Text(
					option,
					style: const TextStyle(
						color: Colors.white,
					),
				),
				onPressed: () => _checkAnswer(option)
			),
		);
}

	@override
	Widget build(BuildContext context) {

		return FutureBuilder<bool>(
			future: initQuestion(),
			builder: (context, AsyncSnapshot<bool> snapshot) {
				if (snapshot.hasData) {
					return getScaffold();
				}
				else {
					return const CircularProgressIndicator();
				}
			}
		);
	}

	Widget getScaffold() {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Theme.of(context).colorScheme.inversePrimary,
				title: Text("${Instance.activeQuestion!.examSemester}, " 
				"Exam ${Instance.activeQuestion!.examUnit}, Q${Instance.activeQuestion!.questionNum}"),
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Container(
							color: Colors.cyan,
							width: 400,
							height: 200,
							child: Center(
								child: Text(
									Instance.activeQuestion!.given,
									textAlign: TextAlign.center,
									style: const TextStyle(
										color: Colors.black,
									),
								),
							),
						),
						for (String option in answerList!) 
							displayAnswerContainer(option),
					],
				),
			),
		);
	}
}
