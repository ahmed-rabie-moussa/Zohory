import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zohory/models/http_exception.dart';
import 'package:zohory/providers/auth.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_logo.dart';
import '../widgets/backgrounded_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const route = "/signUpScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode _mailFocusNode;
  FocusNode _phoneFocusNode;
  FocusNode _passwordFocusNode;

  String _name = "";
  String _email = "";
  String _phone = "";
  String _password = "";

  @override
  void initState() {
    _mailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _mailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_validate()) {
      try {
        await Provider.of<Auth>(context, listen: false)
            .signup(_email, _password).then((value) {
          final auth = Provider.of<Auth>(context, listen: false);
          print("token : ${value["Token"]}");
          print("userId : ${value["userId"]}");
           auth.addUserInfo(value["Token"],value["userId"], _email, _name, _phone);
        });
        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
      } on HttpException catch (error) {
        var errorMessage = 'Authentication failed';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use.';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This is not a valid email address';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMessage = 'This password is too weak.';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Could not find a user with that email.';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Invalid password.';
        }
        _showErrorDialog(errorMessage);
      } catch (error) {
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }

      // setState(() {
      //   _isLoading = false;
      // });
    } else
      return;
  }

  bool _validate() {
    if (_name.isEmpty ||
        _phone.isEmpty ||
        _password.isEmpty ||
        _email.isEmpty) {
      _showErrorDialog("Please, Fill empty fields");
      return false;
    }
    bool validate = true;
    RegExp phoneRegEXp =
        RegExp("^01[0-2]{1}[0-9]{8}", caseSensitive: false, multiLine: false);
    RegExp nameRegEXp = RegExp("^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*\$",
        caseSensitive: false, multiLine: false);
    // RegExp passwordRegEXp = RegExp(
    //     "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}\$",
    //     caseSensitive: false,
    //     multiLine: false);
    RegExp emailRegEXp = RegExp(
        "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        caseSensitive: false,
        multiLine: false);
    if (!nameRegEXp.hasMatch(_name)) {
      _showErrorDialog("Please, Enter a valid Name");
      validate = false;
    } else if (!emailRegEXp.hasMatch(_email)) {
      _showErrorDialog("Please, Enter a valid E-Mail");
      validate = false;
    } else if (!phoneRegEXp.hasMatch(_phone)) {
      _showErrorDialog("Please, Enter a valid Phone Number");
      validate = false;
    }
    // else if (!passwordRegEXp.hasMatch(_password)) {
    //   _showErrorDialog(
    //       "Please, Enter a valid Password that contains uppercase letters, lowercase letters, numbers, and special characters.");
    //   validate = false;
    // }
    return validate;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
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
              onTap: () =>
                  Navigator.of(context).pop(),
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
          Text("Register",
              style: GoogleFonts.quicksand(
                textStyle: Theme.of(context).textTheme.display1,
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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Name",
                    isObsecure: false,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      _name = value.toString();
                    },
                    onSubmitted: (value) {
                      _mailFocusNode.requestFocus();
                    },
                  ),
                  Divider(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: "Email Address",
                    isObsecure: false,
                    textInputAction: TextInputAction.next,
                    focusNode: _mailFocusNode,
                    // textEditingController: _mailController,
                    onChanged: (value) {
                      _email = value.toString();
                    },
                    onSubmitted: (value) {
                      _phoneFocusNode.requestFocus();
                    },
                  ),
                  Divider(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: "Phone",
                    isObsecure: false,
                    textInputAction: TextInputAction.next,
                    focusNode: _phoneFocusNode,
                    // textEditingController: _mailController,
                    onChanged: (value) {
                      _phone = value.toString();
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                  ),
                  Divider(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: "Password",
                    isObsecure: true,
                    textInputAction: TextInputAction.done,
                    focusNode: _passwordFocusNode,
                    // textEditingController: _mailController,
                    onChanged: (value) {
                      _password = value.toString();
                    },
                    onSubmitted: (value) => _submitForm(),
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            isColored: true,
            text: "Sign Up",
            onTap: () => _submitForm(),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }
}
