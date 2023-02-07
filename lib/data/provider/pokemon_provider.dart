import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pokemonapp/data/client/api_client.dart';
import 'package:pokemonapp/data/model/pokemon_model.dart';

import '../model/pokemon_detail_model.dart';

class PokemonProvider {
  final ApiClient _client = ApiClient();
  Future<dynamic> getPokemons({int offset = 0, int limit = 20}) async {
    try {
      Response response = await _client.get(
          endpoint: "pokemon/", params: {"offset": offset, "limit": limit});

      if (response.statusCode == HttpStatus.ok) {
        return PokemonModel.fromJson(response.data);
      } else {
        return Exception("Failed to load data");
      }
    } catch (e) {
      return Exception("Failed to load data");
    }
  }

  Future<dynamic> getPokemonDetail({required String name}) async {
    try {
      Response response = await _client.get(endpoint: "pokemon/$name");

      if (response.statusCode == HttpStatus.ok) {
        return PokemonDetailModel.fromJson(response.data);
      } else {
        return Exception("Failed to load data");
      }
    } catch (e) {
      return Exception("Failed to load data");
    }
  }
}
