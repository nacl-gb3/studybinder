import 'question.dart';
import 'user.dart';
import 'dart:math';

class Exam {
	String semester = "";
	int unit = -1;
	List<Question> questions = [];

	//Exam(this.semester, this.unit, this.questions);

	Exam.fromJson(Map data); 

	Question? getRandomQuestion(User user, Random rand, bool excludeAnswered) {
		int index = -1;
		List<int>? answeredQuestions;

		if (!user.answeredQuestions.containsKey(this.toString())) {
			return null;
		} 

		answeredQuestions = user.answeredQuestions[this.toString()];

		if (answeredQuestions == null) {
			return null;
		}

		if (excludeAnswered || answeredQuestions.length != this.questions.length) {
			while (answeredQuestions.contains(index)) {
				index = rand.nextInt(this.questions.length);
			}
		}
	
		return this.questions[index];
	}

	@override
	String toString() {
		return "$semester, Unit $unit";
	}
	
}
