import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';
import '../widgets/question_card.dart';
import '../widgets/gradient_background.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.quizCompleted) {
          // Navigate to result screen when quiz is completed
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ResultScreen()),
            );
          });
        }

        return GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text(
                'Flutter Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // Progress indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.totalQuestions}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Question card
                  Expanded(
                    child: QuestionCard(
                      question: quizProvider.currentQuestion,
                      onOptionSelected: (index) {
                        quizProvider.selectAnswer(index);
                      },
                    ),
                  ),
                  
                  // Next button
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: quizProvider.currentQuestion.selectedAnswerIndex != null
                            ? () => quizProvider.nextQuestion()
                            : null,
                        style: TextButton.styleFrom(
                          backgroundColor: quizProvider.currentQuestion.selectedAnswerIndex != null
                              ? Colors.deepPurple
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          quizProvider.currentQuestionIndex < quizProvider.totalQuestions - 1
                              ? 'Next Question'
                              : 'Finish Quiz',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}