import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.buttonTitle, required this.onTap,});

  final String buttonTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(3),
            backgroundColor: buttonTitle == 'Next'
                ? WidgetStateProperty.all(Colors.greenAccent)
                : WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              buttonTitle,
              style: TextStyle(
                  fontSize: 20, color: Colors.blueGrey.shade700, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
