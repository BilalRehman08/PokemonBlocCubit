import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/color_utils.dart';

class PokemonCardWidget extends StatelessWidget {
  final String imgPath;
  final String name;
  final int experience;
  final int weight;
  final int height;
  final onPressed;
  final Color? color;
  const PokemonCardWidget(
      {super.key,
      required this.imgPath,
      required this.name,
      required this.experience,
      required this.weight,
      required this.height,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorUtils.cardColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              height: 140,
              width: 140,
              child: SvgPicture.network(
                imgPath,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Experience: $experience",
                    ),
                    const SizedBox(height: 10),
                    Text("Weight: $weight"),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Height: $height"),
                        IconButton(
                            onPressed: onPressed,
                            icon: Icon(
                              Icons.favorite,
                              color: color,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
