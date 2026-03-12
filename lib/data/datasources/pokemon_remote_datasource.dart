import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_list_item_model.dart';

class PokemonRemoteDatasource {
  final http.Client client;

  PokemonRemoteDatasource({required this.client});

  Future<List<PokemonListItemModel>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    final response = await client.get(
      Uri.parse(ApiConstants.pokemonList(limit: limit, offset: offset)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load pokemon list');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List results = data['results'] as List<dynamic>;

    return results.map((item) => PokemonListItemModel.fromJson(item)).toList();
  }

  Future<PokemonDetailModel> getPokemonDetail(String nameOrId) async {
    final response = await client.get(
      Uri.parse(ApiConstants.pokemonDetail(nameOrId)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load pokemon detail');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    return PokemonDetailModel.fromJson(data);
  }
}
