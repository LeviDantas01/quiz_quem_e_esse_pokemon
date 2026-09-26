import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_quem_e_esse_pokemon/repository/pokemon.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/components/custom_shimmer.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/components/placar.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/pokedex_view.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({
    super.key,
    required this.list,
  });

  final List<Pokemon> list;

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  final Random _random = Random();

  /// Working copy so the original list stays intact for the pokedex / replay.
  late List<Pokemon> _remaining;

  int _acerto = 0;
  int _erro = 0;
  int _indexQuestion = 0;

  /// Whether the current pokemon has been guessed correctly (reveals the image).
  bool _revealed = false;

  List<Pokemon> _alternatives = [];

  @override
  void initState() {
    super.initState();
    _remaining = List<Pokemon>.from(widget.list);
    _prepareQuestion();
  }

  /// Builds 4 unique alternatives, always including the correct pokemon.
  void _prepareQuestion() {
    if (_remaining.isEmpty) {
      _alternatives = [];
      return;
    }

    if (_indexQuestion >= _remaining.length) {
      _indexQuestion = 0;
    }

    final correct = _remaining[_indexQuestion];
    final options = <Pokemon>{correct};

    // Only add distractors if there are enough pokemons to choose from.
    final maxOptions = min(4, _remaining.length);
    while (options.length < maxOptions) {
      options.add(_remaining[_random.nextInt(_remaining.length)]);
    }

    _alternatives = options.toList()..shuffle(_random);
    _revealed = false;
  }

  Pokemon get _currentPokemon => _remaining[_indexQuestion];

  void _onAnswer(Pokemon chosen) {
    final isCorrect = chosen.name == _currentPokemon.name;

    if (isCorrect) {
      setState(() {
        _acerto++;
        _revealed = true;
      });

      // Reveal the pokemon briefly, then advance to the next question.
      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        setState(() {
          _remaining.remove(_currentPokemon);
          _indexQuestion++;
          _prepareQuestion();
        });
      });
    } else {
      setState(() {
        _erro++;
      });
    }
  }

  void _restart() {
    setState(() {
      _remaining = List<Pokemon>.from(widget.list);
      _acerto = 0;
      _erro = 0;
      _indexQuestion = 0;
      _prepareQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining.isEmpty) {
      return _buildFinishedScreen();
    }

    final currentImage = _currentPokemon.image;

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Placar(
            placar: _acerto,
            cor: Colors.green,
          ),
          Placar(
            placar: _erro,
            cor: Colors.red,
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/paisagem-noturna.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 27),
                child: Image.asset('assets/logo_cruzada.png'),
              ),
              SizedBox(
                height: 140,
                child: _buildPokemonImage(currentImage),
              ),
              const SizedBox(height: 150),
              Column(
                children: _alternatives
                    .map(
                      (pokemon) => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          height: 50,
                          width: 250,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: _revealed ? null : () => _onAnswer(pokemon),
                            child: Text(pokemon.name),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows the pokemon as a black silhouette until it's guessed correctly.
  Widget _buildPokemonImage(String url) {
    final image = Image.network(
      url,
      height: 140,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const CustomShimmer(
          height: 120,
          width: 120,
          baseColor: Colors.white,
          highlightColor: Colors.white,
        );
      },
      errorBuilder: (context, error, stackTrace) => const SizedBox(
        height: 140,
        child: Icon(Icons.catching_pokemon, size: 100, color: Colors.white),
      ),
    );

    if (_revealed) {
      return image;
    }

    // Paint every non-transparent pixel black to create the silhouette.
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      child: image,
    );
  }

  Widget _buildFinishedScreen() {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/paisagem-noturna.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/parabens.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/ash.jpeg.jpg'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _restart,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Jogue novamente'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePagePokedex(list: widget.list),
                      ),
                    );
                  },
                  icon: const Icon(Icons.catching_pokemon),
                  label: const Text('Ver pokedex'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
