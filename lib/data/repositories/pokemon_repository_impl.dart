import '../../domain/entities/pokemon_detail_entity.dart';
import '../../domain/entities/pokemon_list_item_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_datasource.dart';
import '../datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDatasource remoteDatasource;
  final PokemonLocalDatasource localDatasource;

  PokemonRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<List<PokemonListItemEntity>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final result = await remoteDatasource.getPokemonList(
        limit: limit,
        offset: offset,
      );
      print('Fetch from API success');
      if (offset == 0) {
        await localDatasource.cachePokemonList(result);
      }

      return result;
    } catch (_) {
      print('Load from cache');
      if (offset == 0) {
        return localDatasource.getCachedPokemonList();
      }
      rethrow;
    }
  }

  @override
  Future<PokemonDetailEntity> getPokemonDetail(String nameOrId) async {
    try {
      final result = await remoteDatasource.getPokemonDetail(nameOrId);
      await localDatasource.cachePokemonDetail(result);
      return result;
    } catch (_) {
      final cached = localDatasource.getCachedPokemonDetail(nameOrId);
      if (cached != null) return cached;
      rethrow;
    }
  }
}
