import 'package:http/http.dart' as http;
import '../question.dart';
import '../login.dart';

Future<int> initWebDatabase() async {
	Uri url = Uri.http("localhost:5000", "init/${Login.activeCourse}");
	http.Response response = await http.get(url);
	return response.statusCode;		
}

Future<Question> getRandomQuestionWeb() async {
	Uri url = Uri.http("localhost:5000", "select/random");
	http.Response response = await http.get(url);
	return Question.fromJson(response.body);
}

