import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';
import 'exam.dart';
import 'question.dart';
import 'native/appdb.dart';
import 'native/drift.dart';
import 'web/server.dart';

class Instance {
	static User? activeUser;
	static Exam? activeExam;
	static Question? activeQuestion;
	static AppDatabase? activeCourseDB;
	static List<User> users = [];

    static QuestionTypes? nextType;

	static void setCourseDatabase() async {
		if (activeCourseDB != null) {
			activeCourseDB!.close();
		}

		if (kIsWeb) {
			int statusCode = await initWebDatabase();	
			if (statusCode != 200) {
				throw Exception("Web Error $statusCode");
			}
		}

		else {
			activeCourseDB = AppDatabase();

			if (activeCourseDB == null) {
				throw const FileSystemException("Database not found");
			}
		}
	}

	static Future<void> setRandomQuestion() async {
		if (kIsWeb) {
			activeQuestion = await getRandomQuestionWeb(nextType);	
		}
		else {
			activeQuestion = await getRandomQuestionNative(User.dummy(), activeCourseDB!, nextType);	
		}

        nextType = null;
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
