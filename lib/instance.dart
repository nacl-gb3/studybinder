import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'user.dart';
import 'exam.dart';
import 'paths.dart';

class Instance {
	User? activeUser;
	List<User> users = [];
	List<Exam> exams = [];

	Instance() {
		this.users = this.getUsers();
		this.exams = this.getExams();
	}

	List<User> getUsers() {
		List<User> users = [];

		Directory usersDirectory = Directory(usersPath);

		if (!usersDirectory.existsSync()) {
			usersDirectory.createSync();
		}

		else {
			List<FileSystemEntity> files = usersDirectory.listSync();

			for (int i = 0; i < files.length; i++) {
				if (files[i] is File) {
					String contents = (files[i] as File).readAsStringSync();
					Map json = jsonDecode(contents);
					User user = User.fromJson(json);
					users.add(user);
				}
			}
		}

		return users;
	}

	List<Exam> getExams() {
		List<Exam> exams = [];

		Directory examsDirectory = Directory(examsPath);

		if (!examsDirectory.existsSync()) {
			examsDirectory.createSync();
		}

		else {
			List<FileSystemEntity> files = examsDirectory.listSync();

			for (int i = 0; i < files.length; i++) {
				if (files[i] is File) {
					String contents = (files[i] as File).readAsStringSync();
					Map json = jsonDecode(contents);
					Exam exam = Exam.fromJson(json);
					exams.add(exam);
				}
			}
		}

		return exams;
	}

	bool userLogIn(String username, int id, String password) {
		for (int i = 0; i < users.length; i++) {
			if (users[i].name == username && users[i].id == id && encrypt(password) == users[i].password) {
				activeUser = users[i];
				return true;
			}
		}

		return false;
	}

	void userLogOut() {
		activeUser = null;
	}

	String encrypt(String string) {
		List<int> bytes = utf8.encode(string);
		Digest digest = sha256.convert(bytes);
		return digest.toString();
	}

	int onClose() {
		for (int i = 0; i < users.length; i++) {
			String username = users[i].name;
			String jsonString = jsonEncode(users[i]);
			File userFile = File("$usersPath/$username.json");
			userFile.writeAsStringSync(jsonString);
		}

		for (int i = 0; i < exams.length; i++) {
			String examId = exams[i].semester + exams[i].unit.toString();
			String jsonString = jsonEncode(users[i]);
			File examFile = File("$examsPath/$examId.json");
			examFile.writeAsStringSync(jsonString);
		}

		return 0;
	}

}
