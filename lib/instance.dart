import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'user.dart';
import 'exam.dart';
import 'question.dart';
import 'paths.dart';

class Instance {
	User? activeUser;
	Exam? activeExam;
	List<User> users = [];
	Map<String, List<Exam>> exams = {};

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

	bool userLogIn(String username, int id, String password) {
		for (int i = 0; i < this.users.length; i++) {
			if (this.users[i].name == username && this.users[i].id == id 
				&& encrypt(password) == this.users[i].password) {
				activeUser = this.users[i];
				return true;
			}
		}

		return false;
	}

	void userLogOut() {
		this.activeUser = null;
		this.deactivateExam();
	}

	Question? getRandomQuestion(User user, Random rand, bool excludeAnswered) {
		Exam? exam;

		do {
			exam = getRandomExam(rand);
		} while (excludeAnswered && user.answeredQuestions.length == this.getExamCount()
		&& exam.questions.length == user.answeredQuestions[exam.toString()]!.length);	

		return exam.getRandomQuestion(user, rand, excludeAnswered);
	}

	Exam getRandomExam(Random rand) {
		Iterable<String> semesters = this.exams.keys;
		int index = rand.nextInt(semesters.length);
		String semester = semesters.elementAt(index);
		int length = this.exams[semester]!.length;
		int unit = rand.nextInt(length);
		return this.exams[semester]![unit];
	}

	int getExamCount() {
		int count = 0;

		this.exams.forEach( (key, value) {
			for (int i = 0; i < value.length; i++) {
				count++;
			}
		});

		return count;
	}

	int activateExam(String semester, int unit) {
		if (!this.exams.containsKey(semester)) {
			return 1;
		}

		if (unit > this.exams[semester]!.length) {
			return 2;
		}

		this.activeExam = this.exams[semester]![unit-1];

		return 0;
	}

	void deactivateExam() {
		this.activeExam = null;
	}

	String encrypt(String string) {
		List<int> bytes = utf8.encode(string);
		Digest digest = sha256.convert(bytes);
		return digest.toString();
	}

	int onClose() {
		for (int i = 0; i < this.users.length; i++) {
			String username = this.users[i].name;
			String jsonString = jsonEncode(users[i]);
			File userFile = File("$usersPath/$username.json");
			userFile.writeAsStringSync(jsonString);
		}

		this.exams.forEach( (key, value) {
			for (int i = 0; i < value.length; i++) {
				String examId = value[i].semester + "Unit" + value[i].unit.toString();
				String jsonString = jsonEncode(value[i]);
				File examFile = File("$examsPath/$examId.json");
				examFile.writeAsStringSync(jsonString);
			}
		});

		return 0;
	}

}
