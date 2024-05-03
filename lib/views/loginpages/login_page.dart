import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:totalx/views/loginpages/verify_otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumbercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 150,
                child: Image.asset('assets/images/image.png'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Enter Phone Number',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: phoneNumbercontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Enter Phone Number '),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                    text: "by Continuing, i agree to TotalX's",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 12),
                  ),
                  TextSpan(
                    text: 'Terms and condition',
                    style: TextStyle(
                        color: Colors.lightBlueAccent[200],
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                  const TextSpan(
                    text: '&',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'privacy policy',
                    style: TextStyle(
                        color: Colors.lightBlueAccent[200],
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  )
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException exception) {},
                      codeSent: (String verificationid, int? redendtoken) {},
                      codeAutoRetrievalTimeout: (String verfificationid) {},
                      phoneNumber: phoneNumbercontroller.text.toString());

                  String lastTwoDigits = phoneNumbercontroller.text.length >= 2
                      ? phoneNumbercontroller.text
                          .substring(phoneNumbercontroller.text.length - 2)
                      : phoneNumbercontroller.text;
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => OtpVerificationPage(
                      last2dig: lastTwoDigits,
                    ),
                  ));
                },
                child: const Text(
                  'Get OTP',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
