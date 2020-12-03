import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import '../widgets/backgrounded_screen.dart';

class ActivationScreen extends StatefulWidget {
  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;

  Future<void> verifyPhone(phoneNo, BuildContext context) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      // _showErrorDialog("PhoneVerificationCompleted", context);
      print("PhoneVerificationCompleted");
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      // _showErrorDialog('${authException.message}', context);
          print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      print("verificationId : $verId");
      print("forceResend : ${forceResend.toString()}");
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      print("verificationId : $verId");
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }


  void _showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundedScreen(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(left: 24, top: 64),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text("Activation",
                  style: GoogleFonts.quicksand(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .display1,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  )),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      PinCodeTextField(
                        maxLength: 6,
                        pinTextStyle: TextStyle(
                            fontSize: 32,
                            color: Colors.grey.shade700,
                            decoration: TextDecoration.none),
                        defaultBorderColor: Colors.transparent,
                        hasTextBorderColor: Colors.transparent,
                        hasUnderline: true,
                        pinBoxOuterPadding: EdgeInsets.all(0),
                        pinBoxWidth: MediaQuery.of(context).size.width*0.12,
                        onDone: (codeDone) {
                          setState(() {
                            smsCode = codeDone;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              CustomButton(isColored: true, text: "Done", onTap: () {
                codeSent
                    ? PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: smsCode)
                    : mobile(context);
              },),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text("Send Code Again",
                    style: GoogleFonts.quicksand(
                      textStyle: Theme
                          .of(context)
                          .textTheme
                          .display1,
                      fontSize: 22,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
  Future<void> mobile (BuildContext context) async {
    await Firebase.initializeApp();
    return verifyPhone("+20 1009 409 220", context);
  }
}
