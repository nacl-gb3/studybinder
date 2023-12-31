import 'package:flutter/foundation.dart';
import 'dart:math';
import 'user.dart';
import 'question.dart';
import 'appdb.dart';

Future<Question> getRandomQuestion(User user, AppDatabase db) async {
	List<QuestionEntry> questionEntries = await db.select(db.questions).get();
	Random rand = Random();

	List<Question> questions = [];

	while (questionEntries.isNotEmpty) {
		int randomIndex = rand.nextInt(questionEntries.length);
		QuestionEntry questionEntry = questionEntries[randomIndex];
		Question question = Question.fromDB(questionEntry);
		questions.add(question);
		questionEntries.removeAt(randomIndex);
	}

	int index = 0;
	//while (user.excludeAnswered && questions[index].usersAnswered.contains(user.name)) {index++;}

	return questions[index];
}

