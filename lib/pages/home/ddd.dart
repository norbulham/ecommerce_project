import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  // Function to launch the URL
  void _launchURL() async {
    const url = 'https://bnbfree.in/?r=22796';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promo Page'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _launchURL, // Launch the URL when tapped
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Win Free BNB every hour! - ',
                  style: TextStyle(
                    fontSize: 24, // equivalent to size=15pt in HTML
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'www.bnbfree.in',
                  style: TextStyle(
                    fontSize: 24, // equivalent to size=15pt in HTML
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
