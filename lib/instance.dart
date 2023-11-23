import 'dart:io';
import 'user.dart';
import 'exam.dart';

class Instance {
	User activeUser = User();
	List<User> users = [];
	List<Exam> exams = [];

	Instance() {
		this.users = this.getUsers();
		this.exams = this.getExams();
	}

	List<User> getUsers() {
		return [];
	}

	List<Exam> getExams() {
		return [];
	}

	bool logIn(String username) {
		for (int i = 0; i < users.length; i++) {
			if (users[i].name == username) {
				activeUser = users[i];
				return true;
			}
		}

		return false;
	}

	void logOut() {
		activeUser = User();
	}

}
