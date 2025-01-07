import 'package:flutter/material.dart';

class ChooseDifficulty extends StatelessWidget {
  const ChooseDifficulty({
    super.key,
    required this.title,
    required this.onTap,
    required this.selectedDiff,
  });

  final String title;
  final String selectedDiff;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        radius: 12,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selectedDiff == title.toLowerCase()
                ? Colors.greenAccent.shade200
                : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
