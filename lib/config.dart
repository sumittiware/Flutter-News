import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

Future<void> share(String url) async {
  await Share.share(url, subject: "Share news");
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
