// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

launchYouTube() async {
  const url = 'https://www.youtube.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchMateri() async {
  const url = 'https://www.ruangguru.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
