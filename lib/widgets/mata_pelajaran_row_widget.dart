import 'package:flutter/material.dart';

class MapelRowWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  MapelRowWidget({
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.lightBlue),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }
}
