import 'package:flutter/material.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/home/failure.dart';
import 'package:quiz_quem_e_esse_pokemon/repository/pokemon.dart';
import 'package:quiz_quem_e_esse_pokemon/repository/pokemon_repository.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/home/home_error.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/home/home_loading.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/principal_screen.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key, required this.repository});
  final IPokemonRepository repository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: repository.getAllPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HomeLoading();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            snapshot.data!.shuffle();
            return PrincipalScreen(
              list: snapshot.data!,
            );
          }

          if (snapshot.hasError) {
            return HomeError(
              error: (snapshot.error as Failure).message!,
            );
          }

          return Container();
        });
  }
}
