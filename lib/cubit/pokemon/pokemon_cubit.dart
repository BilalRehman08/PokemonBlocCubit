import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemonapp/data/model/pokemon_detail_model.dart';
import 'package:pokemonapp/data/repositories/pokemon_repo.dart';
import 'package:pokemonapp/storage/favorite_storage.dart';

import '../../main.dart';
part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit()
      : super(const PokemonState(
          isLoading: false,
          offset: 0,
          limit: 10,
        ));

  PokemonRepo repo = PokemonRepo();
  FavoritePokemonStorage favoritePokemonStorage = FavoritePokemonStorage();

  fetchPokemons({required BuildContext context}) async {
    emit(state.copyWith(isLoading: true));
    getPokemons();
    final List<PokemonDetailModel> favList = state.favpokemons;

    var pokemons =
        await repo.getPokemons(offset: state.offset, limit: state.limit);
    List<PokemonDetailModel> pokDetails = [];

    if (pokemons != null) {
      for (var i = 0; i < pokemons.results.length; i++) {
        var response =
            await repo.getPokemonDetail(name: pokemons.results[i].name);
        favList.map((e) => e.name).toList().contains(response.name)
            ? response.isFavorite = true
            : response.isFavorite = false;
        pokDetails.add(response);
      }
    }
    print("offset ${state.offset} limit ${state.limit}");
    emit(state.copyWith(
        isLoading: false,
        pokemons: pokDetails,
        offset: state.offset + state.limit));
  }

  Future<void> loadMorePokemons() async {
    emit(state.copyWith(isLoadMoreLoading: true));
    final newPokemons =
        await repo.getPokemons(offset: state.offset, limit: state.limit);
    final List<PokemonDetailModel> poks = state.pokemons;
    final List<PokemonDetailModel> favList = state.favpokemons;

    List<PokemonDetailModel> pokDetails = [];
    if (newPokemons != null) {
      for (var i = 0; i < newPokemons.results.length; i++) {
        var response =
            await repo.getPokemonDetail(name: newPokemons.results[i].name);
        favList.map((e) => e.name).toList().contains(response.name)
            ? response.isFavorite = true
            : response.isFavorite = false;
        pokDetails.add(response);
      }
    }
    // if (newPokemons != null) {
    //   for (var i = 0; i < newPokemons.results.length; i++) {
    //     var response =
    //         await repo.getPokemonDetail(name: newPokemons.results[i].name);
    //     pokDetails.add(response);
    //   }
    // }

    poks.addAll(pokDetails);
    emit(state.copyWith(
        pokemons: poks,
        offset: state.offset + state.limit,
        isLoadMoreLoading: false));
  }

  void addPokemon({required PokemonDetailModel pokemon}) {
    String email = prefs.getString('email')!;
    emit(state.copyWith(
      pokemons: state.pokemons.map((e) {
        if (e.name == pokemon.name) {
          e.isFavorite = true;
          print(e.isFavorite);
        }
        return e;
      }).toList(),
    ));
    List<PokemonDetailModel> fav = [];
    pokemon.isFavorite = true;
    fav.addAll(state.favpokemons);
    fav.add(pokemon);
    emit(state.copyWith(favpokemons: fav));
    favoritePokemonStorage.saveFavorites(email, fav);
  }

  deletePokemon({required PokemonDetailModel pokemon}) {
    String email = prefs.getString('email')!;
    emit(state.copyWith(
      pokemons: state.pokemons.map((e) {
        if (e.name == pokemon.name) {
          e.isFavorite = false;
        }
        return e;
      }).toList(),
    ));
    List<PokemonDetailModel> fav = [];
    fav.addAll(state.favpokemons);
    emit(state.copyWith(favpokemons: fav));
    fav.remove(pokemon);
    favoritePokemonStorage.saveFavorites(email, fav);
  }

  getPokemons() {
    List<PokemonDetailModel>? fav;
    emit(state.copyWith(favpokemons: []));
    String email = prefs.getString('email')!;
    fav = favoritePokemonStorage.getFavorites(email);
    emit(state.copyWith(favpokemons: fav));
  }

  resetOffSet() {
    emit(state.copyWith(offset: 0, limit: 10));
  }
}
