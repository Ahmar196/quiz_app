import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;

  final List<Question> _questions = [
    Question(
      questionText: "What is Flutter?",
      options: [
        "A database management system",
        "A UI toolkit for building natively compiled applications",
        "A programming language",
        "A backend framework"
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Which programming language is used for Flutter development?",
      options: ["JavaScript", "Java", "Dart", "Python"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "What is a StatefulWidget in Flutter?",
      options: [
        "A widget that never changes",
        "A widget that can change its appearance in response to events",
        "A widget used only for navigation",
        "A widget used only for animations"
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "What is the Flutter's widget tree?",
      options: [
        "A data structure to store user preferences",
        "A hierarchical organization of widgets that make up the UI",
        "A tool for debugging Flutter apps",
        "A special kind of animation"
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "What is hot reload in Flutter?",
      options: [
        "A feature that allows you to quickly reload the app with new code changes",
        "A feature that prevents the app from crashing",
        "A performance optimization technique",
        "A feature that automatically updates packages"
      ],
      correctAnswerIndex: 0,
    ),
  ];

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  int get score => _score;
  bool get quizCompleted => _quizCompleted;
  int get totalQuestions => _questions.length;

  void selectAnswer(int index) {
    if (_questions[_currentQuestionIndex].selectedAnswerIndex != null) return;
    
    _questions[_currentQuestionIndex].selectedAnswerIndex = index;
    
    if (_questions[_currentQuestionIndex].isCorrect) {
      _score++;
    }
    
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      _quizCompleted = true;
      notifyListeners();
    }
  }

  String getFeedback() {
    if (_score <= 2) {
      return "Keep practicing!";
    } else if (_score <= 4) {
      return "Good job!";
    } else {
      return "Excellent!";
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _quizCompleted = false;
    
    for (var question in _questions) {
      question.selectedAnswerIndex = null;
    }
    
    notifyListeners();
  }
}
