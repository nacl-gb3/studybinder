import 'package:drift/drift.dart';

@DataClassName('UserEntry')
class Users extends Table {
	@override String get tableName => 'users';
	TextColumn get name => text()();
	IntColumn get id  => integer()();
	TextColumn get password => text()();
	IntColumn get admin => integer()();
	IntColumn get excludeAnswered => integer()();
}

@DataClassName('QuestionEntry')
class Questions extends Table {
	@override String get tableName => 'questions';
	TextColumn get examSemester => text()();
	IntColumn get examUnit  => integer()();
	IntColumn get questionNum  => integer()();
	TextColumn get type => text()();
	TextColumn get given => text()();
	TextColumn get explanation => text()();
	TextColumn get answer => text()();
	TextColumn get possibleAnswers => text()();
	TextColumn get usersAnswered => text()();
}
