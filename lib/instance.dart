import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
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

	static void setCourseDatabase() async {
		if (activeCourseDB != null) {
			activeCourseDB!.close();
		}

		activeCourseDB = AppDatabase();

		if (activeCourseDB == null) {
			throw const FileSystemException("Database not found");
		}

		if (kIsWeb) {
			fillWebAppDB(activeCourseDB!);
		}
	}

	static Future<void> setRandomQuestion() async {
		//if (!kIsWeb) {
		activeQuestion = await getRandomQuestion(User.dummy(), activeCourseDB!);	
		//}
		//else {
		// HTTP Stuff
		//}
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

	static int activateExam(String semester, int unit) {
		activeExam = Exam(semester, unit);
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
