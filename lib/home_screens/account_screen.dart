import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:const BoxDecoration(
                gradient: GlobalVariables.appBarGradient
              ),
            ),
            title: Row(
              children: [
                Container(
                 alignment: Alignment.topLeft,
                 child: Image.asset('assets/images/amazon_in.png',width: 125,height: 40,),
                )
              ],
            ),
          )),
    );
  }
}
