import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_pop_up.dart';
import '../screens/hasil_pengajuan_screen.dart';
import '../screens/materi_screen.dart';
import '../widgets/build_story_widget.dart';
import 'pengajuan_revisi.dart';

class HomeScreenRevisi extends StatefulWidget {
  const HomeScreenRevisi({Key? key}) : super(key: key);

  @override
  State<HomeScreenRevisi> createState() => _HomeScreenRevisiState();
}

class _HomeScreenRevisiState extends State<HomeScreenRevisi> {
  final user = FirebaseAuth.instance.currentUser!;

  Future<Map<String, dynamic>> fetchUserData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return userDoc.data() as Map<String, dynamic>;
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'STUSAMA',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.none,
            letterSpacing: 1.0,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
              Shadow(
                color: Colors.blue,
                offset: Offset(0, 2),
                blurRadius: 3,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () async {
              // Fetch user data from Firestore
              Map<String, dynamic> userData = await fetchUserData();
              String name = userData['name'] ?? 'Unknown';
              String email = userData['email'] ?? 'Unknown';
              String phoneNumber = userData['phone'] ?? 'Unknown';
              String role = 'Student'; // Static role

              // Show the profile pop-up with user data
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ProfilePopup(
                    name: name,
                    email: email,
                    phoneNumber: phoneNumber,
                    role: role,
                  );
                },
              );
            },
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_sharp),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      //drawer: MenuDrawer(currentPage: 'Halaman Utama'),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/flutter-background1.jpg",
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.lightBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    height: 250,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Apa yang Ingin Kamu Pelajari",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Hari Ini?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 18),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PengajuanRevisi()),
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Mulai',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 20,
                          bottom: 0,
                          left: 130,
                          child: Image.asset(
                            'assets/flutter-image7.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          buildStoryItem(
                            Icons.upload_file_outlined,
                            'Pengajuan',
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PengajuanRevisi(),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 22),
                          buildStoryItem(
                            Icons.access_time_sharp,
                            'Hasil',
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HasilPengajuan(
                                    selectedSubject: '',
                                    pickedDate: null,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 22),
                          buildStoryItem(
                            Icons.book_online_sharp,
                            'Materi',
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MateriScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
