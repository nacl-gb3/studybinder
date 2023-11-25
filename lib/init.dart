import 'dart:io';
import 'dart:convert';
import 'user.dart';
import 'exam.dart';
//import 'question.dart';
import 'paths.dart';

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

Map<String, List<Exam>> getExams() {
	Map<String, List<Exam>> exams = {};

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

				if (!exams.containsKey(exam)) {
					exams[exam.toString()] == [exam];
				}
				else {
					exams[exam.toString()]!.add(exam);
				}
			}
		}
	}

	return exams;
}

