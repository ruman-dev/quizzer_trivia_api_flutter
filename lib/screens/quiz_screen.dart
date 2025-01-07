import 'package:flutter/material.dart';
import 'package:win_by_quiz/models/quiz_model.dart';
import 'package:win_by_quiz/screens/result_screen.dart';
import 'package:win_by_quiz/services/api_services.dart';
import 'package:win_by_quiz/widgets/bottom_button.dart';
import 'package:win_by_quiz/widgets/options.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.quizCount, required this.difficulty});

  final int quizCount;
  final String difficulty;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool isLoading = true;
  final ApiServices _apiServices = ApiServices();
  QuizModel? _quizModel;
  int _currentIndex = 0;
  String? _selectedOption;
  List<String>? _shuffledOptions;
  List<String> optionIndex = ['A', 'B', 'C', 'D'];
  final List<Map<String, Object>> _userAnswers = [];
  String? flag;
  String? _currentQuestion;
  String? _correctAnswer;

  void _loadScreen() async {
    var result = await _apiServices.getQuiz(
        'https://opentdb.com/api.php?amount=${widget.quizCount}&difficulty=${widget.difficulty}&type=multiple');
    _quizModel = QuizModel.fromJson(result);
    _shuffleOptions();
    setState(() {
      isLoading = false;
    });
  }

  void checkForResults() {
    if (_currentIndex < (_quizModel?.results?.length ?? 0) - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _shuffleOptions();
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            result: _userAnswers,
          ),
        ),
      );
    }
  }

  void _shuffleOptions() {
    if (_quizModel != null && _quizModel!.results != null) {
      _shuffledOptions = List.from(_quizModel!.results![_currentIndex].allOptions);
      _shuffledOptions!.shuffle();
    }
  }

  void _skipQuestion() {
    checkForResults();
  }

  @override
  void initState() {
    super.initState();
    _loadScreen();
  }

  void _nextQuestion(String currentQuestion, String userSelectedAns, String correctAnswer) {
    if (_selectedOption != null) {
      _userAnswers.add({
        'index': _currentIndex,
        'question': currentQuestion,
        'user_ans': flag!,
        'correct_ans': correctAnswer
      });
    }
    checkForResults();
  }

  void _onOptionsTap(String option, String index) {
    setState(() {
      _selectedOption = option;
      flag = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading &&
        _quizModel != null &&
        _quizModel!.results != null &&
        _quizModel!.results!.isNotEmpty) {
      _currentQuestion = _quizModel!.results![_currentIndex].question!;
      _correctAnswer = _quizModel!.results![_currentIndex].correctAnswer!;
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1}/${_quizModel?.results?.length ?? 0}'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent.shade700,
              ),
            )
          : _quizModel == null || _quizModel!.results == null || _quizModel!.results!.isEmpty
              ? Center(
                  child: Text('No quiz data available'),
                )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.greenAccent.shade700),
                        padding: EdgeInsets.all(30),
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Center(
                          child: Text(
                            _currentQuestion!,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Expanded(
                        child: ListView.builder(
                            itemCount: _shuffledOptions!.length,
                            itemBuilder: (context, index) {
                              return Options(
                                  index: optionIndex[index],
                                  option: _shuffledOptions![index],
                                  onPressed: () =>
                                      _onOptionsTap(optionIndex[index], _shuffledOptions![index]),
                                  isSelected: _selectedOption == optionIndex[index]);
                            }),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          BottomButton(
                            buttonTitle: 'Skip',
                            onTap: _skipQuestion,
                          ),
                          const SizedBox(width: 10),
                          BottomButton(
                            buttonTitle: 'Next',
                            onTap: () => _nextQuestion(_currentQuestion!, flag!, _correctAnswer!),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
    );
  }
}
