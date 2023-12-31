import 'appdb.dart';

void fillWebAppDB(AppDatabase appDB) async {
	// HTTP stuff will go here one day

	QuestionEntry questionEntry = const QuestionEntry(
		examSemester: "Fall 2023",
		examUnit: 2,
		questionNum: 3,
		type: "Multiple Choice",
		given: "memes",
		explanation: "no memes",
		answer: "why not",
		possibleAnswers: "why not, who, when, why",
		usersAnswered: ""
	);

	appDB.into(appDB.questions).insert(questionEntry);	

	print(await appDB.select(appDB.questions).get());
}
