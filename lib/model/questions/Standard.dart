import 'Question.dart';

class Standard extends Question {
  final List<String> answers;

  Standard({required String title, required this.answers, required int id})
      : super(title: title, id: id);
}
