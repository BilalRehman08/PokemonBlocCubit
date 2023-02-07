import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemonapp/cubit/pokemon/pokemon_cubit.dart';
import 'package:pokemonapp/utils/color_utils.dart';

import '../routes/route_names.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/loading_widget.dart';
import '../widgets/pokemon_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonCubit>().fetchPokemons(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.secondaryColor,
        title: const Text("Pokemon App"),
        actions: [
          IconButton(
              onPressed: () {
                showLogoutDialog(context: context);
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      backgroundColor: ColorUtils.bgColor,
      body: SafeArea(child: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(
                  child: LoadingBlinkingImage(),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: ListView.builder(
                    itemCount: state.pokemons.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.pokemons.length) {
                        return state.isLoadMoreLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: ColorUtils.secondaryColor,
                              ))
                            : Container(
                                margin: const EdgeInsets.all(10),
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ColorUtils.secondaryColor,
                                    ),
                                    child: const Text("Load More"),
                                    onPressed: () {
                                      context
                                          .read<PokemonCubit>()
                                          .loadMorePokemons();
                                    },
                                  ),
                                ),
                              );
                      } else {
                        return Padding(
                            padding: const EdgeInsets.all(10),
                            child: PokemonCardWidget(
                                imgPath: state.pokemons[index].sprites!.other!
                                    .dreamWorld!.frontDefault!,
                                name: state.pokemons[index].name!.toUpperCase(),
                                experience:
                                    state.pokemons[index].baseExperience!,
                                weight: state.pokemons[index].weight!,
                                color: state.pokemons[index].isFavorite!
                                    ? Colors.red
                                    : Colors.grey,
                                height: state.pokemons[index].height!,
                                onPressed: () {
                                  if (state.pokemons[index].isFavorite!) {
                                    context.read<PokemonCubit>().deletePokemon(
                                        pokemon: state.pokemons[index]);
                                  } else {
                                    context.read<PokemonCubit>().addPokemon(
                                        pokemon: state.pokemons[index]);
                                  }
                                }));
                      }
                    },
                  ),
                );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PokemonCubit>().getPokemons();
          Navigator.pushNamed(context, RouteNames.favorite);
        },
        child: const Icon(
          Icons.favorite,
          size: 30,
        ),
      ),
    );
  }
}
