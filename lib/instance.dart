import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';
import 'exam.dart';
import 'question.dart';
import 'appdb.dart';
import 'fill_db.dart';
import 'drift.dart';

class Instance {
	static User? activeUser;
	static Exam? activeExam;
	static Question? activeQuestion;
	static AppDatabase? activeCourseDB;
	static List<User> users = [];
	static Map<String, List<Exam>> exams = {};
	static List<Question> questions = [];

	static void setCourseDatabase() {
		if (activeCourseDB != null) {
			activeCourseDB!.close();
		}

		activeCourseDB = AppDatabase();

		if (activeCourseDB == null) {
			throw const FileSystemException("Database not found");
		}

		print(kIsWeb);
		if (kIsWeb) {
			fillWebAppDB(activeCourseDB!);
		}
	}

	static Future<void> setRandomQuestion() async {
		activeQuestion = await getRandomQuestion(User.dummy(), activeCourseDB!);	
	}

	static bool userLogIn(String username, int id, String password) {
		for (int i = 0; i < users.length; i++) {
			if (users[i].name == username && users[i].id == id 
				&& encrypt(password) == users[i].password) {
				activeUser = users[i];
				return true;
			}
		}

		return false;
	}

	static void userLogOut() {
		activeUser = null;
		deactivateExam();
	}

	static Exam getRandomExam(Random rand) {
		Iterable<String> semesters = exams.keys;
		int index = rand.nextInt(semesters.length);
		String semester = semesters.elementAt(index);
		int length = exams[semester]!.length;
		int examIndex = rand.nextInt(length);
		return exams[semester]![examIndex];
	}

	static int getExamCount() {
		int count = 0;

		exams.forEach( (key, value) {
			for (int i = 0; i < value.length; i++) {
				count++;
			}
		});

		return count;
	}

	static int activateExam(String semester, int unit) {
		if (!exams.containsKey(semester)) {
			return 1;
		}

		if (unit > exams[semester]!.length) {
			return 2;
		}

		for (int i = 0; i < exams[semester]!.length; i++) {
			if (exams[semester]![i].unit == unit) {
				activeExam = exams[semester]![i];
			}
		}

		return 0;
	}

	static void deactivateExam() {
		activeExam = null;
	}

	static String encrypt(String string) {
		List<int> bytes = utf8.encode(string);
		Digest digest = sha256.convert(bytes);
		return digest.toString();
	}

	static int onClose() {
		activeCourseDB!.close();
		return 0;
	}

}
