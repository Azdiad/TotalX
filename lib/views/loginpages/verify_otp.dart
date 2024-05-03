import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/vrification_controller.dart';
import 'package:totalx/views/homepage/homepage.dart';

class OtpVerificationPage extends StatelessWidget {
  final String last2dig;

  OtpVerificationPage({
    required this.last2dig,
    required phonenumber,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpVerificationProvider(),
      child: OtpVerificationWidget(last2dig: last2dig),
    );
  }
}

class OtpVerificationWidget extends StatelessWidget {
  final String last2dig;

  OtpVerificationWidget({required this.last2dig});

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpVerificationProvider>(context);

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
                  child: Image.asset('assets/images/image2.png'),
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'OTP Verification',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  'Enter the verification code we just sent to your number +91 ********$last2dig'),
              const SizedBox(height: 20),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                onCompleted: (value) {
                  otpProvider.setOtp(value);
                },
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${otpProvider.counter} Sec',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      if (otpProvider.otps!.isNotEmpty &&
                          otpProvider.otps!.allMatches(otpProvider.otps!) ==
                              true) {
                        await Provider.of<OtpVerificationProvider>(context,
                                listen: false)
                            .otps;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Incorrect OTP. Please try again.'),
                          ),
                        );
                      }
                    },
                    child: RichText(
                      text: const TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "Don't Get OPT?",
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: 'Resend',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 6, 131, 233),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Consumer<OtpVerificationProvider>(
                  builder: (context, otpprovider, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        await Provider.of<OtpVerificationProvider>(context,
                                listen: false)
                            .otps;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                      },
                      child: const Text(
                        'Verify',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
