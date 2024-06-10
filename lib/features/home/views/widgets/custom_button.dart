import 'package:flutter/material.dart';

class CustmoButton extends StatelessWidget {
  const CustmoButton(
      {super.key,
      required this.color,
      required this.btnText,
      required this.callback});
  final Color color;
  final String btnText;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(color),
          minimumSize: const MaterialStatePropertyAll(Size(151, 46))),
      onPressed: callback,
      child: Text(
        btnText,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
      ),
    );
  }
}
