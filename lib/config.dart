import 'dart:ui';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

final mainColor = Color(0xFF2b2c28);
final thirdColor = Color(0xFF7de2d1);
final secondColor = Color(0xFF339989);
final bgColor = Color(0xFFfffafb);

Future<void> share(String url) async {
  await FlutterShare.share(
      title: 'News app',
      text: 'Check this out!!!',
      linkUrl: url,
      chooserTitle: 'Example Chooser Title');
}

Future<void> launchInWebViewOrVC(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
    );
  } else {
    //Scaffold.of(context).showSnackBar();
    throw 'Could not launch $url';
  }
}
