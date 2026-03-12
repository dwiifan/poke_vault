import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_detail_entity.dart';
import '../../domain/usecases/get_pokemon_detail.dart';

class PokemonDetailProvider extends ChangeNotifier {
  final GetPokemonDetail getPokemonDetail;

  PokemonDetailProvider({required this.getPokemonDetail});

  PokemonDetailEntity? pokemon;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPokemonDetail(String nameOrId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      pokemon = await getPokemonDetail(nameOrId);
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
