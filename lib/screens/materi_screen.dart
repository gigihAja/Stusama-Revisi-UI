import 'package:flutter/material.dart';
import '../widgets/mata_pelajaran_row_widget.dart';
//import '../widgets/menu_drawer.dart';
import '../widgets/search_bar_widget.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MateriScreen extends StatefulWidget {
  const MateriScreen({Key? key}) : super(key: key);

  @override
  _MateriScreenState createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen>
    with SingleTickerProviderStateMixin {
  late String _selectedOption;
  bool _showContainers = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  List<String> numberImages = [
    "assets/flutter-image2.png",
    "assets/flutter-image3.jpg",
    "assets/flutter-image6.png",
    "assets/flutter-image10.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _selectedOption = 'Matematika';
    _showContainers = true;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateSelectedSubject(String subject) {
    setState(() {
      _selectedOption = subject;
      _showContainers = true;
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 210, 245, 245),
        title: Row(
          children: [
            Text(
              'Materi',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Pelajaran',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
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
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      //drawer: MenuDrawer(currentPage: 'Materi'),
      body: GestureDetector(
        onTap: () {
          if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
            _scaffoldKey.currentState?.openEndDrawer();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 210, 245, 245),
                Color.fromARGB(255, 255, 255, 255),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: screenSize.width * 0.8,
                    height: 50,
                    child: SearchBarApp(
                      onSubjectSelected: updateSelectedSubject,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Mata Pelajaran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    MapelRowWidget(
                      text: "Matematika",
                      onTap: () => updateSelectedSubject("Matematika"),
                      isSelected: _selectedOption == "Matematika",
                    ),
                    MapelRowWidget(
                      text: "Bahasa Indonesia",
                      onTap: () => updateSelectedSubject("Bahasa Indonesia"),
                      isSelected: _selectedOption == "Bahasa Indonesia",
                    ),
                    MapelRowWidget(
                      text: "Bahasa Inggris",
                      onTap: () => updateSelectedSubject("Bahasa Inggris"),
                      isSelected: _selectedOption == "Bahasa Inggris",
                    ),
                  ],
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return _showContainers
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: numberImages.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FadeTransition(
                                  opacity: _animation,
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 192, 235, 255),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${_selectedOption} ${index + 1}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                            shadows: [
                                              Shadow(
                                                color: Colors.white,
                                                blurRadius: 2,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Image.asset(
                                              numberImages[index],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
