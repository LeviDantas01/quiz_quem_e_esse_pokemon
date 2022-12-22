import 'package:flutter/material.dart';

class Placar extends StatefulWidget {
  const Placar({
    super.key,
    required this.placar,
    required this.cor,
  });

  final int placar;
  final Color cor;

  @override
  State<Placar> createState() => _PlacarState();
}

class _PlacarState extends State<Placar> {
  
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: widget.cor,
          height: 50,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            "${widget.placar}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
