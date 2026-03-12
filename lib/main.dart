import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'core/services/hive_service.dart';
import 'data/datasources/pokemon_local_datasource.dart';
import 'data/datasources/pokemon_remote_datasource.dart';
import 'data/repositories/pokemon_repository_impl.dart';
import 'domain/usecases/get_pokemon_detail.dart';
import 'domain/usecases/get_pokemon_list.dart';
import 'presentation/pages/detail_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/providers/pokemon_detail_provider.dart';
import 'presentation/providers/pokemon_list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  final client = http.Client();
  final remoteDatasource = PokemonRemoteDatasource(client: client);
  final localDatasource = PokemonLocalDatasource();

  final repository = PokemonRepositoryImpl(
    remoteDatasource: remoteDatasource,
    localDatasource: localDatasource,
  );

  final getPokemonList = GetPokemonList(repository);
  final getPokemonDetail = GetPokemonDetail(repository);

  runApp(
    MyApp(getPokemonList: getPokemonList, getPokemonDetail: getPokemonDetail),
  );
}

class MyApp extends StatelessWidget {
  final GetPokemonList getPokemonList;
  final GetPokemonDetail getPokemonDetail;

  const MyApp({
    super.key,
    required this.getPokemonList,
    required this.getPokemonDetail,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PokemonListProvider>(
          create: (_) => PokemonListProvider(getPokemonList: getPokemonList),
        ),
        ChangeNotifierProvider<PokemonDetailProvider>(
          create: (_) =>
              PokemonDetailProvider(getPokemonDetail: getPokemonDetail),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Poke Vault',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
          '/detail': (context) => const DetailPage(),
        },
      ),
    );
  }
}
