import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../widgets/menu_drawer.dart';

final GlobalKey<ScaffoldState> _hasilPengajuanScaffoldKey =
    GlobalKey<ScaffoldState>();

final db = FirebaseFirestore.instance;

class HasilPengajuan extends StatefulWidget {
  const HasilPengajuan({
    Key? key,
    required this.selectedSubject,
    required this.pickedDate,
  }) : super(key: key);

  final String? selectedSubject;
  final DateTime? pickedDate;

  @override
  State<HasilPengajuan> createState() => _HasilPengajuanState();
}

class _HasilPengajuanState extends State<HasilPengajuan> {
  Future<void> _deleteDocument(String documentId) async {
    await db.collection('Hasil Pengajuan').doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _hasilPengajuanScaffoldKey,
      backgroundColor: Color.fromARGB(255, 250, 254, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Hasil',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Pengajuan',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _hasilPengajuanScaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      //drawer: MenuDrawer(currentPage: 'Hasil Pengajuan'),
      body: GestureDetector(
        onTap: () {
          if (_hasilPengajuanScaffoldKey.currentState?.isDrawerOpen ?? false) {
            _hasilPengajuanScaffoldKey.currentState?.openEndDrawer();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/flutter-background4.jpg',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('Hasil Pengajuan').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text('No submissions available.'),
                          );
                        }
                        final hasilPengajuan = snapshot.data!.docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return Hasil(
                            jadwal: data['tanggal_ajuan'],
                            matpel: data['matpel_ajuan'],
                            documentId: doc.id,
                          );
                        }).toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: hasilPengajuan.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(hasilPengajuan[index].documentId),
                              onDismissed: (direction) async {
                                await _deleteDocument(
                                    hasilPengajuan[index].documentId);
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Mata Pelajaran : ${hasilPengajuan[index].matpel}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Tanggal : ${hasilPengajuan[index].jadwalDateTime != null ? DateFormat('dd-MM-yyyy').format(hasilPengajuan[index].jadwalDateTime!) : "Not Available"}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Hasil {
  final String? jadwal;
  final String? matpel;
  final String documentId;

  Hasil({
    required this.jadwal,
    required this.matpel,
    required this.documentId,
  });

  DateTime? get jadwalDateTime {
    if (jadwal != null) {
      try {
        return DateFormat('dd-MM-yyyy').parse(jadwal!);
      } catch (e) {
        print('Error parsing date: $e');
        return null;
      }
    }
    return null;
  }
}
