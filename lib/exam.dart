import 'dart:math';
import 'question.dart';
import 'user.dart';

class Exam {
	String semester = "";
	int unit = -1;
	List<Question> questions = [];

	//Exam(this.semester, this.unit, this.questions);

	Exam.fromJson(Map data); 

	Question? getRandomQuestion(User user, bool excludeAnswered) {
		Random rand = Random();
		int index = -1;
		List<int> attemptedIndexes = [];

		if (excludeAnswered) {
			do {
				index = rand.nextInt(this.questions.length);
				if (!attemptedIndexes.contains(index)){
					attemptedIndexes.add(index);
				}
			} while (questions[index].usersAnswered.contains(user.name) 
			&& attemptedIndexes.length < this.questions.length);
		}

	
		return this.questions[index];
	}

	@override
	String toString() {
		return "$semester, Unit $unit";
	}
	
}
