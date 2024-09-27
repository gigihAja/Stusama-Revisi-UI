import 'package:flutter/material.dart';
import 'package:stusama_revisi_ui/screens/hasil_pengajuan_screen.dart';
import 'package:stusama_revisi_ui/screens/home_screen_revisi.dart';
import 'package:stusama_revisi_ui/screens/materi_screen.dart';
import 'package:stusama_revisi_ui/screens/pengajuan_revisi.dart';

class MenuDrawer extends StatefulWidget {
  final String currentPage;

  MenuDrawer({
    required this.currentPage,
  });

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SlideTransition(
      position: _offsetAnimation,
      child: Drawer(
        child: Container(
          width: screenSize.width / 2,
          height: screenSize.height,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: Text('Halaman Utama'),
                onTap: () {
                  if (widget.currentPage != 'Halaman Utama') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreenRevisi(),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                selected: widget.currentPage == 'Halaman Utama',
              ),
              ListTile(
                title: Text('Pengajuan'),
                onTap: () {
                  if (widget.currentPage != 'Pengajuan') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PengajuanRevisi(),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                selected: widget.currentPage == 'Pengajuan',
              ),
              ListTile(
                title: Text('Hasil Pengajuan'),
                onTap: () {
                  if (widget.currentPage != 'Hasil Pengajuan') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HasilPengajuan(
                          selectedSubject: '', // Provide a default value
                          pickedDate: null, // Handle null value
                        ),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                selected: widget.currentPage == 'Hasil Pengajuan',
              ),
              ListTile(
                title: Text('Materi'),
                onTap: () {
                  if (widget.currentPage != 'Materi') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MateriScreen(),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                selected: widget.currentPage == 'Materi',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
