import 'package:flutter/material.dart';
import 'package:win_by_quiz/win_by_quiz_app.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.result,
  });

  final List<Map<String, Object>> result;

  List<Map<String, Object>> getSummary() {
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Quizzer Score'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey.shade800,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                  'Your Score: ${result.where((element) => element['user_ans'] == element['correct_ans']).length} / ${result.length}',
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey.shade300,
                          child: Text(
                            '${(result[index]['index'] as int) + 1}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        title: Text(
                          '${result[index]['question']}',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${result[index]['user_ans']}\n${result[index]['correct_ans']}',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        trailing: result[index]['user_ans'] == result[index]['correct_ans']
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.greenAccent.shade700,
                              )
                            : Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                              ),
                      );
                    }),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  result.clear();
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => WinByQuizApp()));
                },
                child: Text('Restart Quiz'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}
