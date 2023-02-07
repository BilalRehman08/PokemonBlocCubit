import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemonapp/widgets/pokemon_card.dart';
import '../cubit/pokemon/pokemon_cubit.dart';
import '../utils/color_utils.dart';

class Favoriteview extends StatelessWidget {
  const Favoriteview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.secondaryColor,
        title: const Text("FAVORITE POKEMONS"),
      ),
      backgroundColor: ColorUtils.bgColor,
      body: SafeArea(child: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: ListView.builder(
              itemCount: state.favpokemons.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: PokemonCardWidget(
                        imgPath: state.favpokemons[index].sprites!.other!
                            .dreamWorld!.frontDefault!,
                        name: state.favpokemons[index].name!.toUpperCase(),
                        experience: state.favpokemons[index].baseExperience!,
                        weight: state.favpokemons[index].weight!,
                        height: state.favpokemons[index].height!,
                        color: state.favpokemons[index].isFavorite!
                            ? Colors.red
                            : Colors.grey,
                        onPressed: () {
                          if (state.favpokemons[index].isFavorite!) {
                            context.read<PokemonCubit>().deletePokemon(
                                pokemon: state.favpokemons[index]);
                          } else {
                            context
                                .read<PokemonCubit>()
                                .addPokemon(pokemon: state.favpokemons[index]);
                          }
                        }));
              },
            ),
          );
        },
      )),
    );
  }
}
