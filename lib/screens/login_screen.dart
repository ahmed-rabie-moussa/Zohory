import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zohory/models/http_exception.dart';
import 'package:zohory/providers/auth.dart';
import 'package:zohory/screens/home_screen.dart';
import 'package:zohory/screens/signup_screen.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_logo.dart';
import '../widgets/backgrounded_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = "/loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _passwordFocusNode;
  String _email = "";
  String _password = "";

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_validate()) {
      try {
        await Provider.of<Auth>(context, listen: false).login(
          _email,
          _password,
        );
        Navigator.of(context).pushReplacementNamed(MyHomePage.route);
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
    } else
      return;
  }

  bool _validate() {
    if (_password.isEmpty || _email.isEmpty) {
      _showErrorDialog("Please, Fill empty fields");
      return false;
    }
    bool validate = true;
    // RegExp passwordRegEXp = RegExp(
    //     "^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}\$",
    //     caseSensitive: false,
    //     multiLine: false);
    RegExp emailRegEXp = RegExp(
        "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        caseSensitive: false,
        multiLine: false);
    if (!emailRegEXp.hasMatch(_email)) {
      _showErrorDialog("Please, Enter a valid E-Mail");
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
          AppLogo(
            padding: EdgeInsets.only(top: 40),
            logoSize: 25,
          ),
          SizedBox(
            height: 40,
          ),
          Text("Login",
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
                    hintText: "Email",
                    isObsecure: false,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      _email = value.toString();
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
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      _password = value.toString();
                    },
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            isColored: true,
            text: "Login",
            onTap: () => _submitForm(),
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            isColored: false,
            text: "Create Account",
            onTap: () =>
                Navigator.of(context).pushNamed(SignUpScreen.route),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Text("Forget Password?",
                style: GoogleFonts.quicksand(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 22,
                  color: Colors.black.withOpacity(0.6),
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
}
