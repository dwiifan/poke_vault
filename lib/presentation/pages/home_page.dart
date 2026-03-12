import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pokemon_list_provider.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/loading_list_shimmer.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PokemonListProvider>().fetchInitialPokemon();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PokemonListProvider>().fetchMorePokemon();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<PokemonListProvider>().fetchInitialPokemon();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PokemonListProvider>();
    final pokemons = controller.filteredPokemons;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Poke Vault'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchBarWidget(onChanged: controller.setSearchQuery),
            const SizedBox(height: 16),
            Expanded(child: _buildBody(controller, pokemons)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(PokemonListProvider controller, List pokemons) {
    if (controller.isLoading) {
      return const LoadingListShimmer();
    }

    if (controller.errorMessage != null && controller.pokemons.isEmpty) {
      return ErrorStateWidget(
        message: controller.errorMessage ?? 'Something went wrong',
        onRetry: controller.fetchInitialPokemon,
      );
    }

    if (pokemons.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: const [
            SizedBox(height: 180),
            Center(child: Text('No Pokémon found')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: pokemons.length + (controller.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= pokemons.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final pokemon = pokemons[index];

          return PokemonCard(
            pokemon: pokemon,
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: pokemon.name);
            },
          );
        },
      ),
    );
  }
}
