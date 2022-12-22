import 'package:flutter/material.dart';

class Alternaivas extends StatefulWidget {
  const Alternaivas({
    super.key,
    required this.questions,
    required this.erro,
    required this.acerto,
  });

  final String questions;
  final int erro;
  final int acerto;

  @override
  State<Alternaivas> createState() => _AlternaivasState();
}

class _AlternaivasState extends State<Alternaivas> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {},
        child: Text(widget.questions),
      ),
    );
  }
}
