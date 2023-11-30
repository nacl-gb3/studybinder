import 'dart:math';
import 'user.dart';
import 'package:sqlite3/sqlite3.dart';

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

	Question.fromSQL(Row questionSQL) {
		this.examSemester = questionSQL["examSemester"];
		this.examUnit = questionSQL["examUnit"];
		this.questionNum = questionSQL["questionNum"];
		this.type = questionSQL["type"];
		this.given = questionSQL["given"];
		this.explanation = questionSQL["explanation"];
		this.answer = questionSQL["answer"];
		this.possibleAnswers = csvToList(questionSQL["possibleAnswers"]);
		this.usersAnswered = csvToList(questionSQL["usersAnswered"]);
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

	void updateUsersAnswered(User user, Database db) {
		if (!usersAnswered.contains(user.name)) { 
			usersAnswered.add(user.name);
		}
	}

	

}


