import 'package:pokemonapp/data/provider/pokemon_provider.dart';

class PokemonRepo {
  final PokemonProvider _provider = PokemonProvider();

  Future<dynamic> getPokemons({int offset = 0, int limit = 20}) async {
    var response = await _provider.getPokemons(offset: offset, limit: limit);
    return response;
  }

  Future<dynamic> getPokemonDetail({required String name}) async {
    var response = await _provider.getPokemonDetail(name: name);
    return response;
  }
}
