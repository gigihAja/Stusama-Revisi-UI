import 'package:flutter/material.dart';
import 'mata_pelajaran_selection.dart';

class MataPelajaranContainer extends StatelessWidget {
  final Size screenSize;
  final String description;
  final String? selectedSubject;
  final Function(String) onSubjectSelected;

  const MataPelajaranContainer({
    Key? key,
    required this.screenSize,
    required this.description,
    required this.selectedSubject,
    required this.onSubjectSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSubjectSelection(context);
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
              Icons.book_online_sharp,
              size: 40,
              color: selectedSubject != null ? Colors.blue : Colors.black,
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: selectedSubject != null ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSubjectSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Mata Pelajaran'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
