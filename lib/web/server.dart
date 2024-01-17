import 'package:http/http.dart' as http;
import '../question.dart';
import '../login.dart';

Future<int> initWebDatabase() async {
    Uri url = Uri.http("localhost:5000", "init/${Login.activeCourse}");
    http.Response response = await http.get(url);
    return response.statusCode;     
}

Future<Question> getRandomQuestionWeb(QuestionTypes? questionTypes) async {
    Uri url;

    if (questionTypes == null) {
        url = Uri.http("localhost:5000", "select/random");
    }
    else {
        int typeIndex = questionTypes.index;
        url = Uri.http("localhost:5000", "select/random/$typeIndex");
    }

    http.Response response = await http.get(url);
    return Question.fromJson(response.body);
}

