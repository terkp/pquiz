import 'package:pfingst_freizeit_quizz/model/questions/Question.dart';

class Order extends Question{
  final List<String> answers;

  Order({required String title, required this.answers, required int id})
      : super(title: title, id: id);
}