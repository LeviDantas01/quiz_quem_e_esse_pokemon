import 'package:flutter/material.dart';
import 'package:quiz_quem_e_esse_pokemon/repository/pokemon_repository.dart';
import 'package:quiz_quem_e_esse_pokemon/screens/home/home_container.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key, required this.repository});
  final PokemonRepository repository;

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height * 10,
        width: MediaQuery.of(context).size.width * 10,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/paisagem-noturna.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
              SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(
                  "assets/Darkrai-PNG-Image.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return HomeContainer(repository: widget.repository);
                      }));
                    },
                    child: const Text("Play"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
