import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/build_pressable_container.dart';
import '../widgets/mata_pelajaran_widget.dart';
import 'package:intl/intl.dart';
//import '../widgets/menu_drawer.dart';
import 'hasil_pengajuan_screen.dart';

final db = FirebaseFirestore.instance;

class PengajuanRevisi extends StatefulWidget {
  const PengajuanRevisi({Key? key}) : super(key: key);

  @override
  State<PengajuanRevisi> createState() => _PengajuanRevisiState();
}

class _PengajuanRevisiState extends State<PengajuanRevisi> {
  bool isAdditionalInfoVisible = false;
  DateTime? pickedDate;
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    String formatDate(DateTime dateTime) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      //drawer: MenuDrawer(currentPage: 'Pengajuan'),
      body: GestureDetector(
        onTap: () {
          if (Scaffold.of(context).isDrawerOpen) {
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.blue,
                    Colors.white,
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halaman',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Pengajuan',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildPressableContainer(
                          context,
                          screenSize,
                          Icons.schedule,
                          'Pilih Tanggal',
                          (DateTime selectedDate) {
                            setState(() {
                              pickedDate = selectedDate;
                            });
                          },
                        ),
                        MataPelajaranWidget(
                          screenSize: screenSize,
                          onSubjectSelected: (String? subject) {
                            setState(() {
                              selectedSubject = subject;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Result',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 7),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isAdditionalInfoVisible = !isAdditionalInfoVisible;
                          });
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.public, color: Colors.white),
                        ),
                      ),
                      if (isAdditionalInfoVisible && pickedDate != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  SizedBox(width: 8),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.schedule,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jadwal yang Diajukan',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        formatDate(pickedDate!),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  SizedBox(width: 24),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.book_online_sharp,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mata Pelajaran yang Dipilih',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        selectedSubject ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              InkWell(
                                onTap: () {
                                  if (pickedDate != null &&
                                      selectedSubject != null) {
                                    String mataPelajaranYangDiajukan =
                                        selectedSubject!;
                                    String jadwalPelajaranYangDiajukan =
                                        formatDate(pickedDate!);
                                    Map<String, dynamic> hasil = {
                                      'matpel_ajuan': mataPelajaranYangDiajukan,
                                      'tanggal_ajuan':
                                          jadwalPelajaranYangDiajukan,
                                    };

                                    try {
                                      db
                                          .collection('Hasil Pengajuan')
                                          .add(hasil);
                                    } catch (e) {
                                      print(e);
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HasilPengajuan(
                                                selectedSubject:
                                                    selectedSubject,
                                                pickedDate: pickedDate,
                                              )),
                                    );
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green[500],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 45),
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
