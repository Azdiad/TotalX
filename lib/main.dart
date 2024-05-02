import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalx/views/loginpages/login_page.dart';

void main() {
  runApp(totalxmain());
}

class totalxmain extends StatelessWidget {
  const totalxmain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      )),
      home: LoginPage(),
    );
  }
}
