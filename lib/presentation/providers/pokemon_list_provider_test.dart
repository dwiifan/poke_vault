import 'package:Pokemon/domain/entities/pokemon_list_item_entity.dart';
import 'package:Pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:Pokemon/presentation/providers/pokemon_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPokemonList extends Mock implements GetPokemonList {}

void main() {
  late MockGetPokemonList mockGetPokemonList;
  late PokemonListProvider provider;

  setUp(() {
    mockGetPokemonList = MockGetPokemonList();
    provider = PokemonListProvider(getPokemonList: mockGetPokemonList);
  });

  test('fetchInitialPokemon success should update pokemon list', () async {
    final fakeData = [
      const PokemonListItemEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/1.png',
      ),
      const PokemonListItemEntity(
        id: 2,
        name: 'ivysaur',
        imageUrl: 'https://example.com/2.png',
      ),
    ];

    when(
      () => mockGetPokemonList(
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => fakeData);

    await provider.fetchInitialPokemon();

    expect(provider.pokemons.length, 2);
    expect(provider.pokemons.first.name, 'bulbasaur');
    expect(provider.errorMessage, null);
    expect(provider.isLoading, false);
  });

  test('fetchInitialPokemon failed should set error message', () async {
    when(
      () => mockGetPokemonList(
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenThrow(Exception('Failed to fetch'));

    await provider.fetchInitialPokemon();

    expect(provider.pokemons.isEmpty, true);
    expect(provider.errorMessage, isNotNull);
    expect(provider.isLoading, false);
  });
}
