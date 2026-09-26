import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:quiz_quem_e_esse_pokemon/api/api_cons.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/home/failure.dart';
import 'package:quiz_quem_e_esse_pokemon/repository/pokemon.dart';

abstract class IPokemonRepository {
  Future<List<Pokemon>> getAllPokemons();
}

class PokemonRepository implements IPokemonRepository {
  final Dio dio;

  PokemonRepository({required this.dio});
  @override
  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final response = await dio.get(ApiConsts.allPokemonsURL);

      // Dio 5.x may return the body already decoded (Map) when the response
      // content-type is JSON, or as a raw String otherwise (e.g. text/plain
      // from GitHub raw). Handle both cases.
      final data = response.data;
      final Map<String, dynamic> json =
          data is String ? jsonDecode(data) as Map<String, dynamic> : data as Map<String, dynamic>;

      final list = json['pokemon'] as List<dynamic>;
      return list.map((e) => Pokemon.fromMap(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Failure(message: 'Não foi possível carregar os dados');
    }
  }
}

