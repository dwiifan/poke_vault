import '../entities/pokemon_list_item_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  Future<List<PokemonListItemEntity>> call({
    required int limit,
    required int offset,
  }) {
    return repository.getPokemonList(limit: limit, offset: offset);
  }
}
