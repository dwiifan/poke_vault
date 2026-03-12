import '../../domain/entities/pokemon_detail_entity.dart';

class PokemonDetailModel extends PokemonDetailEntity {
  const PokemonDetailModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.types,
    required super.abilities,
    required super.hp,
    required super.attack,
    required super.defense,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    final stats = (json['stats'] as List<dynamic>? ?? []);
    final types = (json['types'] as List<dynamic>? ?? []);
    final abilities = (json['abilities'] as List<dynamic>? ?? []);

    int getStat(String statName) {
      try {
        final stat = stats.firstWhere(
          (item) => item['stat']['name'] == statName,
        );
        return stat['base_stat'] ?? 0;
      } catch (_) {
        return 0;
      }
    }

    return PokemonDetailModel(
      id: json['id'] ?? 0,
      name: (json['name'] ?? '').toString().toLowerCase(),
      imageUrl:
          json['sprites']?['other']?['official-artwork']?['front_default'] ??
          '',
      types: types.map((item) => item['type']['name'] as String).toList(),
      abilities: abilities
          .map((item) => item['ability']['name'] as String)
          .toList(),
      hp: getStat('hp'),
      attack: getStat('attack'),
      defense: getStat('defense'),
    );
  }

  factory PokemonDetailModel.fromMap(Map<dynamic, dynamic> map) {
    return PokemonDetailModel(
      id: map['id'] as int,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      types: List<String>.from(map['types'] as List),
      abilities: List<String>.from(map['abilities'] as List),
      hp: map['hp'] as int,
      attack: map['attack'] as int,
      defense: map['defense'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'abilities': abilities,
      'hp': hp,
      'attack': attack,
      'defense': defense,
    };
  }
}
