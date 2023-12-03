import 'package:drift/drift.dart';
import 'dart:math';
import 'appdb.dart';
import 'tables.dart';
import 'user.dart';

class Question {
	String examSemester = "";
	int examUnit = -1;
	int questionNum = -1;
	String type = ""; //"Free Response", "Short Answer", "Multiple Choice", "True/False"
	String given = "";
	String explanation = "";
	String answer = "";
	List<String> possibleAnswers = [];
	List<String> usersAnswered = [];

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
		this.usersAnswered = csvToList(questionEntry.usersAnswered);
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

	void updateUsersAnswered(User user, AppDatabase db) {
		if (!usersAnswered.contains(user.name)) { 
			usersAnswered.add(user.name);
		}
	}
}




