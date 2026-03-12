import 'package:flutter/material.dart';

import '../../core/constants/api_constants.dart';
import '../../domain/entities/pokemon_list_item_entity.dart';
import '../../domain/usecases/get_pokemon_list.dart';

class PokemonListProvider extends ChangeNotifier {
  final GetPokemonList getPokemonList;

  PokemonListProvider({required this.getPokemonList});

  final List<PokemonListItemEntity> _pokemons = [];
  List<PokemonListItemEntity> get pokemons => _pokemons;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;
  String? errorMessage;

  int offset = 0;
  final int limit = ApiConstants.pageLimit;
  String searchQuery = '';

  List<PokemonListItemEntity> get filteredPokemons {
    if (searchQuery.trim().isEmpty) {
      return _pokemons;
    }

    return _pokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          pokemon.id.toString().contains(searchQuery);
    }).toList();
  }

  Future<void> fetchInitialPokemon() async {
    isLoading = true;
    errorMessage = null;
    hasMore = true;
    offset = 0;
    _pokemons.clear();
    notifyListeners();

    try {
      final result = await getPokemonList(limit: limit, offset: offset);

      _pokemons.addAll(result);
      offset += limit;
      hasMore = result.length == limit;
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMorePokemon() async {
    if (isLoadingMore || isLoading || !hasMore) return;

    isLoadingMore = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await getPokemonList(limit: limit, offset: offset);

      _pokemons.addAll(result);
      offset += limit;
      hasMore = result.length == limit;
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoadingMore = false;
    notifyListeners();
  }

  void setSearchQuery(String value) {
    searchQuery = value;
    notifyListeners();
  }
}
