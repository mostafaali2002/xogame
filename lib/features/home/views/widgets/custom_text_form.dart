import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {super.key, required this.hintText, required this.player});
  final String hintText;
  final TextEditingController player;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "please enter your name";
          }
          return null;
        },
        controller: player,
        style: const TextStyle(color: Color(0xffFFFFFF)),
        decoration: InputDecoration(
            filled: true,
            errorStyle: const TextStyle(fontSize: 15),
            fillColor: const Color(0xff7D7B7B),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 22,
              color: Color(0xffFFFFFF),
            )),
      ),
    );
  }
}
