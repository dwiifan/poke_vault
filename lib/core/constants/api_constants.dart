class ApiConstants {
  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const int pageLimit = 20;

  static String pokemonList({required int limit, required int offset}) {
    return '$baseUrl/pokemon?limit=$limit&offset=$offset';
  }

  static String pokemonDetail(String nameOrId) {
    return '$baseUrl/pokemon/$nameOrId';
  }
}
