import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerificationProvider with ChangeNotifier {
  late Timer _timer;
  int _counter = 59;
  String? _otps;
  // String? verificationcode;
  // String? otpcontroller;

  int get counter => _counter;
  String? get otps => _otps;

  OtpVerificationProvider() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        _counter--;
        notifyListeners();
      } else {
        _timer.cancel();
      }
    });
  }

  void disposeTimer() {
    _timer.cancel();
  }

  void setOtp(String value) {
    _otps = value;
    notifyListeners();
  }

  verifybuttons(verificationcode, otpcontroller) async {
    try {
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: verificationcode.toString(),
          smsCode: otpcontroller.toString());
    } catch (ex) {}
  }
}
