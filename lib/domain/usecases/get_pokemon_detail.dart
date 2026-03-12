import '../entities/pokemon_detail_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetail {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  Future<PokemonDetailEntity> call(String nameOrId) {
    return repository.getPokemonDetail(nameOrId);
  }
}
