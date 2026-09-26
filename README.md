# Quem é esse Pokémon? 🎮

Um quiz feito em Flutter no estilo clássico do desenho: a silhueta de um Pokémon
aparece na tela e você precisa adivinhar quem é entre quatro alternativas. Acerte
o máximo que conseguir e acompanhe seu placar de acertos e erros.

## ✨ Funcionalidades

- **Silhueta do Pokémon** — a imagem aparece como sombra preta e é revelada ao acertar.
- **Quatro alternativas** por rodada, sempre com opções únicas (sem repetição e sem "vazar" a resposta).
- **Placar** de acertos e erros em tempo real.
- **Pokédex** — ao concluir o quiz, dá para navegar por todos os Pokémon com nome, número, tipos e cor por tipo.
- **Estados de carregamento e erro** tratados (shimmer no carregamento e tela dedicada em caso de falha de rede).
- **Rejogar** reiniciando o placar e a lista de Pokémon.

## 🛠️ Tecnologias

- [Flutter](https://flutter.dev/) (Dart 3)
- [dio](https://pub.dev/packages/dio) — requisições HTTP
- [shimmer](https://pub.dev/packages/shimmer) — efeito de carregamento
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) — ícone do app

Os dados dos Pokémon vêm da base pública
[PokemonGO-Pokedex](https://github.com/Biuni/PokemonGO-Pokedex) e as imagens de
[pokemon.json](https://github.com/fanzeyi/pokemon.json).

## 📂 Estrutura do projeto

```
lib/
├── main.dart                      # Ponto de entrada e configuração do MaterialApp
├── api/
│   └── api_cons.dart              # Constantes de URL da API
├── repository/
│   ├── pokemon.dart               # Modelo Pokemon (parse, cor por tipo, URL da imagem)
│   └── pokemon_repository.dart    # Busca a lista de Pokémon na API
└── screens/
    ├── initial_screen.dart        # Tela inicial com botão "Play"
    ├── principal_screen.dart      # Tela do quiz (silhueta, alternativas, placar)
    ├── pokedex.dart               # Card de um Pokémon na pokédex
    ├── pokedex_view.dart          # Grid da pokédex
    ├── components/                # Widgets reutilizáveis (placar, shimmer, tipo)
    └── home/                      # Container com estados de loading / erro / sucesso
```

## 🚀 Como executar

Pré-requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install)
(Dart 3) instalado.

```bash
# Instale as dependências
flutter pub get

# Rode em um emulador ou dispositivo conectado
flutter run

# Ou gere o APK de debug
flutter build apk --debug
```

## 🎯 Como jogar

1. Toque em **Play** na tela inicial.
2. Observe a silhueta do Pokémon e escolha entre as quatro alternativas.
3. Ao acertar, a imagem é revelada e o placar de acertos sobe; ao errar, o placar de erros sobe.
4. Continue até adivinhar todos os Pokémon e, no final, explore a **Pokédex** ou jogue novamente.

## 📌 Ideias de melhorias futuras

- Efeitos sonoros de acerto/erro (o app já traz uma trilha nos assets).
- Número fixo de rodadas com tela de resultado e melhor pontuação salva.
- Timer por pergunta.
- Filtro por geração ou tipo de Pokémon.
- Cache de imagens para reduzir o consumo de dados.
