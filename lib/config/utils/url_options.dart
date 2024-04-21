import 'package:url_launcher/url_launcher.dart';

class UrlLaunchOptions {
  Future<void> launchWeb(String url) async {
    final Uri launchUri = Uri.parse(url);
    await launchUrl(
      launchUri,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

 

  Future<void> emailUs() async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: 'provinceofgraceintl@gmail.com',
    );
    await launchUrl(launchUri);
  }

}