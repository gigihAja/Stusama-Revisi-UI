import 'package:flutter/material.dart';

class MataPelajaranWidget extends StatelessWidget {
  final Size screenSize;
  final void Function(String?) onSubjectSelected;

  const MataPelajaranWidget({
    Key? key,
    required this.screenSize,
    required this.onSubjectSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return LogicMataPelajaran(
              onSubjectSelected: onSubjectSelected,
            );
          },
        );
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
            Icon(Icons.book_online_sharp, size: 40, color: Colors.blue),
            SizedBox(height: 15),
            Text(
              "Pilih Mata Pelajaran",
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
}

class LogicMataPelajaran extends StatefulWidget {
  final void Function(String?) onSubjectSelected;

  const LogicMataPelajaran({required this.onSubjectSelected});

  @override
  State<LogicMataPelajaran> createState() => _LogicMataPelajaranState();
}

class _LogicMataPelajaranState extends State<LogicMataPelajaran> {
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSubjectItem('Bahasa Inggris'),
          SizedBox(height: 10),
          buildSubjectItem('Bahasa Indonesia'),
          SizedBox(height: 10),
          buildSubjectItem('Matematika'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.onSubjectSelected(selectedSubject);
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
  }

  Widget buildSubjectItem(String subjectName) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSubject = subjectName;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              selectedSubject == subjectName ? Colors.blue : Colors.transparent,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            subjectName,
            style: TextStyle(
              fontSize: 16,
              color:
                  selectedSubject == subjectName ? Colors.white : Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
