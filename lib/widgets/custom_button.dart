import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 54,
      width: 286,
      decoration: BoxDecoration(
        color: GlobalVariables.secondaryColor,

          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
                textStyle:  const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color:Colors.white)),
          ),
        ],
      ),
    );
  }
}
