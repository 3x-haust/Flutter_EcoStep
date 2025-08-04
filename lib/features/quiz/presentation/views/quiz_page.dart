import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/core/util/app_state_manager.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;

  final List<QuizQuestion> questions = [
    QuizQuestion(
      question: "What makes flooding worse in urban areas?",
      options: [
        "A. Parks and trees",
        "B. Pavement and drainage issues",
        "C. Cars",
        "D. Mountain",
      ],
      correctAnswer: 1,
    ),
    QuizQuestion(
      question: "What is the main cause of climate change?",
      options: [
        "A. Natural disasters",
        "B. Greenhouse gas emissions",
        "C. Ocean currents",
        "D. Solar radiation",
      ],
      correctAnswer: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.5),
          child: Container(color: colors.gray40, height: 2.5),
        ),
      ),
      body: SafeArea(child: Center(child: buildQuizContent(colors))),
    );
  }

  Widget buildQuizContent(ThemeColors colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildQuizHeader(colors),
        const SizedBox(height: 15),
        buildQuestionContent(colors),
        const SizedBox(height: 20),
        buildNextButton(colors),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildQuizHeader(ThemeColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text(
            'Quiz (${currentQuestionIndex + 1}/${questions.length})',
            style: Typo.titleStrong(context, color: colors.gray900),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionContent(ThemeColors colors) {
    final question = questions[currentQuestionIndex];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: Typo.titleStrong(context, color: colors.gray900),
          ),
          const SizedBox(height: 24),
          Column(
            children: question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = selectedAnswerIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAnswerIndex = index;
                    isAnswered = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.primary : colors.gray900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        option,
                        style: Typo.bodyRegular(
                          context,
                          color: isSelected
                              ? colors.gray900
                              : colors.background,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildNextButton(ThemeColors colors) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: isAnswered ? handleNext : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 120),
          decoration: BoxDecoration(
            color: isAnswered ? colors.primary : colors.gray60,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Next',
            style: Typo.titleStrong(context, color: colors.background),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void handleNext() {
    final colors = ThemeColors.of(context);

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        isAnswered = false;
      });
    } else {
      AppStateManager.completeQuiz();
      Get.back();
      Get.snackbar(
        '퀴즈 완료!',
        '모든 퀴즈를 완료했습니다. 이제 기후 미션을 수행하세요!',
        backgroundColor: colors.primary,
        colorText: colors.background,
      );
    }
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}
