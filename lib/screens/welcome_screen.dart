import 'package:flutter/material.dart';
import 'package:win_by_quiz/screens/quiz_screen.dart';
import 'package:win_by_quiz/widgets/choose_difficulty.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final int limit = 20;
  final TextEditingController _numController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedDiff = '';

  @override
  void dispose() {
    _numController.dispose();
    super.dispose();
  }

  void _selectDiff(String name) {
    setState(() {
      _selectedDiff = name.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to Quizzer',
            style: TextStyle(
                fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.greenAccent.shade400),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _numController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a number';
                              }
                              if (int.tryParse(value) == null || int.parse(value) > limit) {
                                return 'Value must be less than or equal to $limit';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text('Enter the number of quiz'),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              ChooseDifficulty(
                                title: 'Easy',
                                onTap: () => _selectDiff('Easy'),
                                selectedDiff: _selectedDiff,
                              ),
                              const SizedBox(width: 20),
                              ChooseDifficulty(
                                title: 'Medium',
                                onTap: () => _selectDiff('Medium'),
                                selectedDiff: _selectedDiff,
                              ),
                              const SizedBox(width: 20),
                              ChooseDifficulty(
                                title: 'Hard',
                                onTap: () => _selectDiff('Hard'),
                                selectedDiff: _selectedDiff,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton.icon(
                            icon: Icon(Icons.arrow_forward_outlined),
                            onPressed: () {
                              final int count = int.parse(_numController.text);
                              if (_formKey.currentState!.validate()) {
                                if (_selectedDiff.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please select a difficulty level'),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => QuizScreen(
                                        quizCount: count,
                                        difficulty: _selectedDiff,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            label: Text('Start Now'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Text('Go now'),
          ),
        ],
      ),
    );
  }
}
