import 'package:drift/drift.dart';
import 'dart:math';
import 'appdb.dart';
import 'tables.dart';

class Question {
	String examSemester = "";
	int examUnit = -1;
	int questionNum = -1;
	String type = ""; //"Free Response", "Short Answer", "Multiple Choice", "True/False"
	String given = "";
	String explanation = "";
	String answer = "";
	List<String> possibleAnswers = [];

	Question();

	Question.fromDB(QuestionEntry questionEntry) {
		this.examSemester = questionEntry.examSemester;
		this.examUnit = questionEntry.examUnit;
		this.questionNum = questionEntry.questionNum;
		this.type = questionEntry.type;
		this.given = questionEntry.given;
		this.explanation = questionEntry.explanation;
		this.answer = questionEntry.answer;
		this.possibleAnswers = csvToList(questionEntry.possibleAnswers);
	}

	Question.fromMap(Map data) {
		this.examSemester = data["examSemester"];
		this.examUnit = data["examUnit"];
		this.questionNum = data["questionNum"];
		this.type = data["type"];
		this.given = data["given"];
		this.explanation = data["explanation"];
		this.answer = data["answer"];
		this.possibleAnswers = csvToList(data["possibleAnswers"]);
	}

	List<String> csvToList(String csv) {
		return csv.split(",");
	}

	List<String>? shuffleAnswers() {
		Random rand = Random();
		if (this.type != "Multiple Choice") {
			return null;
		}

		List<String> shuffledList = ["", "", "", ""];

		for (int i = 0; i < possibleAnswers.length; i++) {
			while (shuffledList[i] == "") {
				int index = rand.nextInt(possibleAnswers.length);
				if (!shuffledList.contains(possibleAnswers[index])) {
					shuffledList[i] = possibleAnswers[index];
				}
			}
		}

		return shuffledList;
	}

}

