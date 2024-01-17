import 'package:flutter/foundation.dart';
import 'dart:math';
import '../user.dart';
import '../question.dart';
import 'appdb.dart';

Future<Question> getRandomQuestionNative(User user, AppDatabase db, QuestionTypes? questionType) async {
    List<QuestionEntry> questionEntries;

    if (questionType == null) {
        questionEntries = await db.select(db.questions).get();
    }
    else {
        int typeIndex = questionType.index;
        String typeString = Question.QUESTION_TYPES[typeIndex];
        questionEntries = await (db.select(db.questions)
            ..where((qE) => qE.type.equals(typeString))
            ).get();
    }

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

