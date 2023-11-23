class User {
	String name = "";
	String password = "";
	int id = -1;
	bool admin = false;
	Map<String, List<int>> answeredQuestions = {};

	User();

	User.fromJson(Map data);
}

