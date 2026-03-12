import '../entities/pokemon_detail_entity.dart';
import '../entities/pokemon_list_item_entity.dart';

abstract class PokemonRepository {
  Future<List<PokemonListItemEntity>> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<PokemonDetailEntity> getPokemonDetail(String nameOrId);
}
