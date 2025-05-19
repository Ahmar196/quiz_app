import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Function(int) onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                question.questionText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  final isSelected = question.selectedAnswerIndex == index;
                  final isCorrect = question.isCorrect && isSelected;
                  final isIncorrect = !question.isCorrect && isSelected;
                  
                  Color? backgroundColor;
                  if (question.selectedAnswerIndex != null) {
                    if (index == question.correctAnswerIndex) {
                      backgroundColor = Colors.green[100];
                    } else if (isIncorrect) {
                      backgroundColor = Colors.red[100];
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: question.selectedAnswerIndex == null
                            ? () => onOptionSelected(index)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? isCorrect
                                      ? Colors.green
                                      : Colors.red
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            color: backgroundColor,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Radio<int>(
                                value: index,
                                groupValue: question.selectedAnswerIndex,
                                onChanged: question.selectedAnswerIndex == null
                                    ? (value) => onOptionSelected(value!)
                                    : null,
                                activeColor: isCorrect
                                    ? Colors.green
                                    : isIncorrect
                                        ? Colors.red
                                        : Colors.deepPurple,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  question.options[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: question.selectedAnswerIndex != null &&
                                            index == question.correctAnswerIndex
                                        ? Colors.green[800]
                                        : isIncorrect
                                            ? Colors.red[800]
                                            : Colors.black87,
                                  ),
                                ),
                              ),
                              if (question.selectedAnswerIndex != null) ...[
                                if (index == question.correctAnswerIndex)
                                  const Icon(Icons.check_circle, color: Colors.green)
                                else if (isIncorrect)
                                  const Icon(Icons.cancel, color: Colors.red),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}