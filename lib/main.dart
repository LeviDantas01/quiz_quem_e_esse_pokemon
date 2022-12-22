import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quiz_quem_e_esse_pokemon/repository/pokemon_repository.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poke Quiz',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: InitialScreen(
        repository: PokemonRepository(
          dio: Dio(),
        ),
      ),
    );
  }
}
