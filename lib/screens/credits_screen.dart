import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credits and Thanks 🙂"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Developer's testimony:",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "This app, in particular, is very close to my heart. "
                "It was my first attempt in building something, "
                "completely from scratch, on my own, with this lovely framework "
                "called Flutter."
                "\n\nIt was also my first Github fork from someone other than my friends.\n\n"
                "I am glad I could make an impact, however small it may be, with this app.\n\n"
                "Also a huge shoutout to my buddy, @sibi361, for kindly letting me use his API.\nHis inspiration lit the fire to get my app all geared up for production and out there for the world to check out. Thanks a bunch!",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
