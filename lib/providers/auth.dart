import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<Map<String, String>> _authenticate(String email, String password,
      String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAU5GlSB6sp7u5IXvSmdG0YmtUG8D_Zo8Y';
    try {
      final response = await http.post(
        url,
        headers: {"content-type": "application/json"},
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      // print(responseData['localId']);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (urlSegment == "signInWithPassword") {
        _token = responseData['idToken'];
        _userId = responseData['localId'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              responseData['expiresIn'],
            ),
          ),
        );
        _autoLogout();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userId,
            'expiryDate': _expiryDate.toIso8601String(),
          },
        );
        prefs.setString('userData', userData);
      }
      else {
        return {
          "userId": responseData['localId'],
          "Token": responseData['idToken'],
        };
      }
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, String>> signup(String email,
      String password,) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
    json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate
        .difference(DateTime.now())
        .inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> addUserInfo(String authToken,String userId, String email, String fullName,
      String phone) async {
    var url =
        'https://firestore.googleapis.com/v1/projects/zohory-59523/databases/(default)/documents/users/?documentId=$userId&key=AIzaSyAU5GlSB6sp7u5IXvSmdG0YmtUG8D_Zo8Y';
    try {
      final response = await http.post(url,
          headers: {'Authorization': 'Bearer $authToken'},
          body: json.encode(
            {
              "fields": {
                "fullName": {"stringValue": fullName},
                "email": {"stringValue": email},
                "phone": {"stringValue": phone}
              }
            },
          ));
    } catch (error) {
      throw (error);
    }
  }

  Future<Map<String, String>> getUserInfo() async {
    var url =
        'https://firestore.googleapis.com/v1/projects/zohory-59523/databases/(default)/documents/users/$userId/?key=AIzaSyAU5GlSB6sp7u5IXvSmdG0YmtUG8D_Zo8Y';
    try {
      final response =
      await http.get(url, headers: {'Authorization': 'Bearer $token'});
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return {};
      }
      Map<String, String> userInfo = {
        "name": extractedData["fields"]["fullName"]["stringValue"],
        "phone": extractedData["fields"]["phone"]["stringValue"],
        "email": extractedData["fields"]["email"]["stringValue"]
      };

      return userInfo;
    } catch (error) {
      throw (error);
    }
  }
}
