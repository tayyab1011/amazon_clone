import 'dart:convert';
import 'package:amazon_clone/home_screens/bottom_nav_bar.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/error_handle.dart';
import 'package:amazon_clone/constants/snack_bar.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser(
      {required String name,
      required String email, 
      required String password,
      required BuildContext context}) async {
    try {
      User user = User(
          id: '',
          name: name,
          address: '',
          email: email,
          password: password,
          type: '',
          token: '');
      http.Response res = await http.post(
          Uri.parse("http://192.168.1.9:3000/api/signUp"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            showSnackBar(context, "Account created");
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void signInuser(
      {required email,
      required password,
      required BuildContext context}) async {
    try {
      http.Response res = await http.post(
          Uri.parse("http://192.168.1.9:3000/api/signIn"),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)['token']);

            Navigator.pushNamedAndRemoveUntil(
                context, BottomNavBar.routeName, (route) => false);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('x-auth-token');
      if (token == null) {
        preferences.setString('x-auth-token', '');
      }
      var tokenRes = await http
          .post(Uri.parse("http://192.168.1.9:3000/tokenIsValid"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http
            .get(Uri.parse("http://192.168.1.9:3000/get"), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        });
        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
