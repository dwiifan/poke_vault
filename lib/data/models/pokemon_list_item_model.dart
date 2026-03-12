import '../../domain/entities/pokemon_list_item_entity.dart';

class PokemonListItemModel extends PokemonListItemEntity {
  const PokemonListItemModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory PokemonListItemModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = _extractIdFromUrl(url);

    return PokemonListItemModel(
      id: id,
      name: json['name'] ?? '',
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }

  factory PokemonListItemModel.fromMap(Map<dynamic, dynamic> map) {
    return PokemonListItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'imageUrl': imageUrl};
  }

  static int _extractIdFromUrl(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments.where((e) => e.isNotEmpty).toList();
    return int.parse(segments.last);
  }
}
