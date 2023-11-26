class User {
	String filePath = "";
	String name = "";
	int id = -1;
	String password = "";
	bool admin = false;
	bool excludeAnswered = true;

	User(this.name, this.id, this.password, this.admin);

	User.fromJson(Map data);

}

