import 'dart:math';

class Question {
	String examSemester = "";
	int examUnit = -1;
	int questionNum = -1;
	String type = "";
	String given = "";
	String explanation = "";
	String answer = "";
	List<String> possibleAnswers = [];

	List<String>? shuffleAnswers(Random rand) {
		if (this.type != "Multiple Choice") {
			return null;
		}

		List<String> shuffledList = [];

		return shuffledList;
	}
}


