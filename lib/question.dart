import 'dart:math';
import 'dart:convert';
import 'native/appdb.dart';

class Question {
	String examSemester = "";
	int examUnit = -1;
	int questionNum = -1;
	String type = ""; //"Free Response", "Short Answer", "Multiple Choice", "True/False"
	String given = "";
	String explanation = "";
	String answer = "";
	List<String> possibleAnswers = [];

    static final List<String> QUESTION_TYPES = ["Free Response", "Short Answer", "Multiple Choice", 
        "True/False"];

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

	Question.fromJson(String jsonString) {
		Map<String, dynamic> questionMap = json.decode(jsonString); 
		this.examSemester = questionMap["examSemester"];
		this.examUnit = questionMap["examUnit"];
		this.questionNum = questionMap["questionNum"];
		this.type = questionMap["type"];
		this.given = questionMap["given"];
		this.explanation = questionMap["explanation"];
		this.answer = questionMap["answer"];
		this.possibleAnswers = csvToList(questionMap["possibleAnswers"]);
	}

	List<String> csvToList(String csv) {
		return csv.split(",");
	}

	List<String>? shuffleAnswers() {
		Random rand = Random();
		if (this.type != QUESTION_TYPES[QuestionTypes.multipleChoice.index]) {
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

enum QuestionTypes {
    freeResponse,
    shortAnswer,
    multipleChoice,
    trueFalse
}
