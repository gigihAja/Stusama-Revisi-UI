import 'package:flutter/material.dart';

Widget buildPressableContainer(
  BuildContext context,
  Size screenSize,
  IconData iconData,
  String labelText,
  Function(DateTime) onDateSelected,
) {
  return GestureDetector(
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2026),
      );

      if (pickedDate != null) {
        onDateSelected(pickedDate);
      }
    },
    child: Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      height: 300,
      width: screenSize.width * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 40,
            color: Colors.blue,
          ),
          SizedBox(height: 10),
          Text(
            labelText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    ),
  );
}
