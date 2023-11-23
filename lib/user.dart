class User {
	String filePath = "";
	String name = "";
	int id = -1;
	String password = "";
	bool admin = false;
	Map<String, List<int>> answeredQuestions = {};

	User(this.name, this.id, this.password, this.admin);

	User.fromJson(Map data);

	void updateAnsweredQuestions(String currentExam, int currentQuestion) {
		if (!answeredQuestions.containsKey(currentExam)) {
			answeredQuestions[currentExam] = [currentQuestion];
		}
		else {
			answeredQuestions[currentExam]!.add(currentQuestion);
		}

		answeredQuestions[currentExam]!.sort();
	}
}

