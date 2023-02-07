import 'dart:convert';
import 'dart:developer';

import 'package:pokemonapp/data/model/pokemon_detail_model.dart';
import 'package:pokemonapp/main.dart';

class FavoritePokemonStorage {
  static final FavoritePokemonStorage _instance =
      FavoritePokemonStorage._internal();
  factory FavoritePokemonStorage() => _instance;
  FavoritePokemonStorage._internal();

  Future<void> saveFavorites(
      String email, List<PokemonDetailModel> favorites) async {
    prefs.setString('$email-favorites', jsonEncode(favorites));
  }

  List<PokemonDetailModel>? getFavorites(String email) {
    String? response = prefs.getString('$email-favorites');
    if (response == null) {
      return null;
    }
    return List.from(jsonDecode(response)).map((e) {
      return PokemonDetailModel.fromJson(e);
    }).toList();
  }
}
