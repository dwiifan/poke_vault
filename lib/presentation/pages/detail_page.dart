import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/pokemon_type_color.dart';
import '../providers/pokemon_detail_provider.dart';
import '../widgets/stat_row.dart';
import '../widgets/type_chip.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      _loaded = true;

      final String name = ModalRoute.of(context)!.settings.arguments as String;

      Future.microtask(() {
        if (!mounted) return;
        context.read<PokemonDetailProvider>().fetchPokemonDetail(name);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonDetailProvider>();
    final pokemon = provider.pokemon;
    final primaryType = pokemon?.types.isNotEmpty == true
        ? pokemon!.types.first
        : 'normal';
    final backgroundColor = getPokemonTypeColor(primaryType);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : provider.errorMessage != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 72,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        provider.errorMessage ?? 'Failed to load detail',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final String name =
                              ModalRoute.of(context)!.settings.arguments
                                  as String;
                          context
                              .read<PokemonDetailProvider>()
                              .fetchPokemonDetail(name);
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            : pokemon == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '#${pokemon.id.toString().padLeft(3, '0')}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: pokemon.types
                        .map(
                          (type) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              type.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 24),
                      padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 180),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Stats',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              StatRow(label: 'HP', value: pokemon.hp),
                              StatRow(label: 'Attack', value: pokemon.attack),
                              StatRow(label: 'Defense', value: pokemon.defense),
                              const SizedBox(height: 24),
                              const Text(
                                'Types',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: pokemon.types
                                    .map((type) => TypeChip(label: type))
                                    .toList(),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Abilities',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: pokemon.abilities
                                    .map(
                                      (ability) => Chip(
                                        label: Text(ability.toUpperCase()),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: pokemon == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 220),
              child: Image.network(
                pokemon.imageUrl,
                width: 180,
                height: 180,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox(
                  width: 180,
                  height: 180,
                  child: Icon(Icons.image_not_supported_outlined, size: 72),
                ),
              ),
            ),
    );
  }
}
