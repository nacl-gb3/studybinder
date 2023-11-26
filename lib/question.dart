import 'dart:math';

class Question {
	String examSemester = "";
	int examUnit = -1;
	int questionNum = -1;
	String type = ""; //"Free Response", "Short Answer", "Multiple Choice", "True/False"
	String given = "";
	String explanation = "";
	String answer = "";
	List<String> possibleAnswers = [];

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


