import 'package:flutter/material.dart';

class MataPelajaranSelection extends StatelessWidget {
  final String? selectedSubject;
  final Function(String) onSubjectSelected;

  const MataPelajaranSelection({
    Key? key,
    required this.selectedSubject,
    required this.onSubjectSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSubjectPopup(context);
      },
      child: Icon(
        Icons.book_online_sharp,
        size: 40,
        color: selectedSubject != null ? Colors.blue : Colors.black,
      ),
    );
  }

  void _showSubjectPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SubjectContainer(
                subjectName: 'Bahasa Inggris',
                isSelected: selectedSubject == 'Bahasa Inggris',
                onSubjectSelected: onSubjectSelected,
              ),
              SizedBox(height: 10),
              SubjectContainer(
                subjectName: 'Bahasa Indonesia',
                isSelected: selectedSubject == 'Bahasa Indonesia',
                onSubjectSelected: onSubjectSelected,
              ),
              SizedBox(height: 10),
              SubjectContainer(
                subjectName: 'Matematika',
                isSelected: selectedSubject == 'Matematika',
                onSubjectSelected: onSubjectSelected,
              ),
            ],
          ),
        );
      },
    );
  }
}

class SubjectContainer extends StatelessWidget {
  final String subjectName;
  final bool isSelected;
  final Function(String) onSubjectSelected;

  const SubjectContainer({
    Key? key,
    required this.subjectName,
    required this.isSelected,
    required this.onSubjectSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onSubjectSelected(subjectName);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              subjectName,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
