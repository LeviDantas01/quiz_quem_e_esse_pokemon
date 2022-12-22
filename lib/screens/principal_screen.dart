import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_quem_e_esse_pokemon/repository/pokemon.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/components/custom_shimmer.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/components/placar.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/pokedex_view.dart';

class PrincipalScreen extends StatefulWidget {
  PrincipalScreen({
    super.key,
    required this.list,
  });

  final List<Pokemon> list;

  int acerto = 0;
  int erro = 0;

  List<Pokemon> getAlternatives(int index) {
    Random random = Random();
    Pokemon randomPokemon1 = list[index];
    Pokemon randomPokemon2 = list[random.nextInt(list.length)];
    Pokemon randomPokemon3 = list[random.nextInt(list.length)];
    Pokemon randomPokemon4 = list[random.nextInt(list.length)];

    List<Pokemon> questionPokmon = [
      randomPokemon1,
      randomPokemon2,
      randomPokemon3,
      randomPokemon4,
    ];

    questionPokmon.shuffle();

    return questionPokmon;
  }

  String getImagePokemon(int index) {
    var randomImagePokemon = list[index].image;
    return randomImagePokemon;
  }

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  bool isLoading = true;
  int indexQuestion = 0;
  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    if (indexQuestion >= widget.list.length) {
      indexQuestion = 0;
    }

    if (widget.list.isEmpty) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 10,
          width: MediaQuery.of(context).size.width * 10,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/paisagem-noturna.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Image.asset('assets/parabens.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/ash.jpeg.jpg'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                    
                    },
                    icon: const Icon(Icons.catching_pokemon),
                    label: const Text('Ver pokedex'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }
    List<Pokemon> setQuestions = widget.getAlternatives(indexQuestion);
    String setImage = widget.getImagePokemon(indexQuestion);
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Placar(
            placar: widget.acerto,
            cor: Colors.green,
          ),
          Placar(
            placar: widget.erro,
            cor: Colors.red,
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 10,
        width: MediaQuery.of(context).size.width * 10,
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
              !isLoading
                  ? SizedBox(
                      height: 140,
                      child: Image.network(
                        setImage,
                        height: 140,
                      ),
                    )
                  : const CustomShimmer(
                      height: 120,
                      width: 120,
                      baseColor: Colors.white,
                      highlightColor: Colors.white,
                    ),
              const SizedBox(
                height: 150,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (widget.list[indexQuestion].name ==
                            setQuestions[0].name) {
                          setState(() {
                            indexQuestion++;
                            widget.list.remove(setQuestions[0]);
                            widget.acerto++;
                          });
                        } else {
                          setState(() {
                            widget.erro++;
                          });
                        }
                      },
                      child: Text(setQuestions[0].name),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (widget.list[indexQuestion].name ==
                            setQuestions[1].name) {
                          setState(() {
                            indexQuestion++;
                            widget.list.remove(setQuestions[1]);
                            widget.acerto++;
                          });
                        } else {
                          setState(() {
                            widget.erro++;
                          });
                        }
                      },
                      child: Text(setQuestions[1].name),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (widget.list[indexQuestion].name ==
                            setQuestions[2].name) {
                          setState(() {
                            indexQuestion++;
                            widget.list.remove(setQuestions[2]);
                            widget.acerto++;
                          });
                        } else {
                          setState(() {
                            widget.erro++;
                          });
                        }
                      },
                      child: Text(setQuestions[2].name),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (widget.list[indexQuestion].name ==
                            setQuestions[3].name) {
                          setState(() {
                            indexQuestion++;
                            widget.list.remove(setQuestions[3]);
                            widget.acerto++;
                          });
                        } else {
                          setState(() {
                            widget.erro++;
                          });
                        }
                      },
                      child: Text(setQuestions[3].name),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
