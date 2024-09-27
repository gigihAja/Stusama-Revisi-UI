import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stusama_revisi_ui/screens/authentication_screen.dart';
import 'provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => DateProvider(),
      child: const MaterialApp(
        home: AuthScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
