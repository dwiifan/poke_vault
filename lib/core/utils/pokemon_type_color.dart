import 'package:flutter/material.dart';

Color getPokemonTypeColor(String type) {
  switch (type.toLowerCase()) {
    case 'grass':
      return Colors.green;
    case 'fire':
      return Colors.orange;
    case 'water':
      return Colors.blue;
    case 'electric':
      return Colors.amber;
    case 'poison':
      return Colors.purple;
    case 'bug':
      return Colors.lightGreen;
    case 'normal':
      return Colors.grey;
    case 'ground':
      return Colors.brown;
    case 'rock':
      return Colors.brown.shade400;
    case 'psychic':
      return Colors.pink;
    case 'ghost':
      return Colors.deepPurple;
    case 'ice':
      return Colors.cyan;
    case 'dragon':
      return Colors.indigo;
    case 'dark':
      return Colors.black87;
    case 'fairy':
      return Colors.pinkAccent;
    case 'fighting':
      return Colors.deepOrange;
    case 'steel':
      return Colors.blueGrey;
    case 'flying':
      return Colors.lightBlue;
    default:
      return Colors.grey;
  }
}
