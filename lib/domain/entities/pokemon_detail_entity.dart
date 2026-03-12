class PokemonDetailEntity {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final int hp;
  final int attack;
  final int defense;

  const PokemonDetailEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.hp,
    required this.attack,
    required this.defense,
  });
}
