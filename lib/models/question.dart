class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  int? selectedAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.selectedAnswerIndex,
  });

  bool get isCorrect => selectedAnswerIndex == correctAnswerIndex;
}