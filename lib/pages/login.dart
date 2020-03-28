import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  String verificationId;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential cred) async {
    final result = await FirebaseAuth.instance.signInWithCredential(cred);
    print("verificationCompleted");
    print(cred);
    print(result);
  };

  final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
    print("verificationFailed");
    print(authException.message);
  };

  final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    print("code sent to " + "+6597377436" + verificationId);
  };

  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    print("time out" + verificationId);
  };
  Future<void> _handleSignIn() async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+6597377436",
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Login'),
              onPressed: () {
                _handleSignIn();
              },
            )
          ],
        ),
      ),
    );
  }
}
