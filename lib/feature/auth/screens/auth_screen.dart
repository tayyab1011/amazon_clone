import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/services/auth_services.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:flutter/material.dart';

enum Auth {
  signIn,
  signUp;
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final signInKey = GlobalKey<FormState>();
  final signUpKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  Auth _auth = Auth.signUp;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  //Api call for sign up
  signUp() {
    authService.signUpUser(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  signIn() {
    authService.signInuser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ListTile(
            tileColor: _auth == Auth.signUp
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundCOlor,
            title: const Text(
              'Create Account',
              style: TextStyle(fontSize: 18),
            ),
            leading: Radio(
                value: Auth.signUp,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                }),
          ),
          if (_auth == Auth.signUp)
            Container(
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: signUpKey,
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your email'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your password'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your name'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () async {
                            if (_emailController.text.isNotEmpty &&
                                _nameController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              await signUp();
                            }
                          },
                          child: const CustomButton(text: 'SignUp'))
                    ],
                  )),
            ),
          ListTile(
            tileColor: _auth == Auth.signIn
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundCOlor,
            title: const Text(
              'SignIn',
              style: TextStyle(fontSize: 18),
            ),
            leading: Radio(
                value: Auth.signIn,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                }),
          ),
          if (_auth == Auth.signIn)
            Container(
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: signUpKey,
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your email'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your password'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                            signIn();
                        }
                        },
                        
                        child: const CustomButton(text: 'SignIn'))
                    ],
                  )),
            )
        ],
      )),
    );
  }
}
