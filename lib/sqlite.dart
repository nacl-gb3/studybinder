import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'user.dart';
import 'question.dart';
import 'paths.dart';

Database? getDatabase(String dbName) {
	String courseFilePath = "$databasePath/$dbName.db";
	File f = File(courseFilePath);

	if (!f.existsSync()) {
		return null;
	}

	Database db = sqlite3.open(courseFilePath);

	return db;
}

Question getRandomQuestion(User user, Database db) {
	ResultSet questionEntries = db.select("SELECT * from questions ORDER BY RANDOM()");	

	List<Question> questions = [];

	for (int i = 0; i < questionEntries.length; i++) {
		Row questionEntry = questionEntries.elementAt(i);
		Question question = Question.fromSQL(questionEntry);
		questions.add(question);
	}

	int index = 0;
	while (user.excludeAnswered && questions[index].usersAnswered.contains(user.name)) {index++;}

	return questions[index];
}
