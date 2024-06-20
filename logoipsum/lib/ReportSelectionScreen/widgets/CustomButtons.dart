import 'package:flutter/material.dart';
import 'package:logoipsum/ReportList/reportlist.dart';
import 'package:logoipsum/Resources/appcolor.dart';

class CustomButton extends StatelessWidget {
  String argument;
  String buttonText;
  CustomButton({super.key, required this.argument, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.pushNamed(context, '/reportlist', arguments: argument);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ReportList(
            reportType: argument,
          );
        }));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.buttonColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
