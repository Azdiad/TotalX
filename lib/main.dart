import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/vrification_controller.dart';
import 'package:totalx/firebase_options.dart';
import 'package:totalx/views/loginpages/login_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(totalxmain());
}

class totalxmain extends StatelessWidget {
  totalxmain({super.key});
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OtpVerificationProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        )),
        home: LoginPage(),
      ),
    );
  }
}
