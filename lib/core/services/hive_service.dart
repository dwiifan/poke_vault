import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String pokemonListBox = 'pokemon_list_box';
  static const String pokemonDetailBox = 'pokemon_detail_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(pokemonListBox);
    await Hive.openBox(pokemonDetailBox);
  }
}
