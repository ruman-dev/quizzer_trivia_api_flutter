import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({
    super.key,
    required this.index,
    required this.option,
    required this.onPressed,
    required this.isSelected,
  });

  final String index;
  final String option;

  final void Function() onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.white,
          ),
          color: isSelected ? Colors.greenAccent.shade100 : Colors.grey.shade100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(index, style: TextStyle(fontSize: 16)),
              Text(option, style: TextStyle(fontSize: 16)),
              Icon(
                Icons.check_circle,
                color: isSelected ? Colors.greenAccent.shade400 : Colors.grey.shade100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
