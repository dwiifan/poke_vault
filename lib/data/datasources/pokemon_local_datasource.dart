import 'package:hive/hive.dart';

import '../../core/services/hive_service.dart';
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_list_item_model.dart';

class PokemonLocalDatasource {
  Box get _pokemonListBox => Hive.box(HiveService.pokemonListBox);
  Box get _pokemonDetailBox => Hive.box(HiveService.pokemonDetailBox);

  Future<void> cachePokemonList(List<PokemonListItemModel> items) async {
    final mappedItems = items.map((e) => e.toMap()).toList();
    await _pokemonListBox.put('list', mappedItems);
  }

  List<PokemonListItemModel> getCachedPokemonList() {
    final data = _pokemonListBox.get('list');
    if (data == null) return [];

    return (data as List)
        .map(
          (item) =>
              PokemonListItemModel.fromMap(Map<dynamic, dynamic>.from(item)),
        )
        .toList();
  }

  Future<void> cachePokemonDetail(PokemonDetailModel model) async {
    final map = model.toMap();
    await _pokemonDetailBox.put('name_${model.name}', map);
    await _pokemonDetailBox.put('id_${model.id}', map);
  }

  PokemonDetailModel? getCachedPokemonDetail(String nameOrId) {
    dynamic data;

    if (int.tryParse(nameOrId) != null) {
      data = _pokemonDetailBox.get('id_$nameOrId');
    } else {
      data = _pokemonDetailBox.get('name_${nameOrId.toLowerCase()}');
    }

    if (data == null) return null;
    return PokemonDetailModel.fromMap(Map<dynamic, dynamic>.from(data));
  }
}
