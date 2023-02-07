part of 'pokemon_cubit.dart';

class PokemonState {
  final bool isLoading;
  final bool isLoadMoreLoading;
  final List<PokemonDetailModel> pokemons;
  final List<PokemonDetailModel> favpokemons;
  final int offset;
  final int limit;

  const PokemonState({
    this.isLoading = false,
    this.pokemons = const [],
    this.favpokemons = const [],
    this.offset = 0,
    this.limit = 20,
    this.isLoadMoreLoading = false,
  });

  PokemonState copyWith({
    bool? isLoading,
    List<PokemonDetailModel>? pokemons,
    List<PokemonDetailModel>? favpokemons,
    int? offset,
    int? limit,
    bool? isLoadMoreLoading,
  }) {
    return PokemonState(
      isLoading: isLoading ?? this.isLoading,
      pokemons: pokemons ?? this.pokemons,
      favpokemons: favpokemons ?? this.favpokemons,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      isLoadMoreLoading: isLoadMoreLoading ?? this.isLoadMoreLoading,
    );
  }
}
