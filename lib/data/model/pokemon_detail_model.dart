class PokemonDetailModel {
  int? baseExperience;
  int? height;
  int? id;
  String? name;
  Sprites? sprites;
  int? weight;
  bool? isFavorite = false;

  PokemonDetailModel(
      {this.baseExperience,
      this.height,
      this.id,
      this.name,
      this.sprites,
      this.weight,
      this.isFavorite});

  PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    baseExperience = json['base_experience'];
    height = json['height'];
    id = json['id'];
    name = json['name'];
    sprites =
        json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null;
    weight = json['weight'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_experience'] = baseExperience;
    data['height'] = height;
    data['id'] = id;
    data['name'] = name;
    if (sprites != null) {
      data['sprites'] = sprites!.toJson();
    }
    data['weight'] = weight;
    data['isFavorite'] = isFavorite;
    return data;
  }
}

class Sprites {
  Other? other;

  Sprites({
    this.other,
  });

  Sprites.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? Other.fromJson(json['other']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (other != null) {
      data['other'] = other!.toJson();
    }

    return data;
  }
}

class Other {
  DreamWorld? dreamWorld;

  Other({
    this.dreamWorld,
  });

  Other.fromJson(Map<String, dynamic> json) {
    dreamWorld = json['dream_world'] != null
        ? DreamWorld.fromJson(json['dream_world'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dreamWorld != null) {
      data['dream_world'] = dreamWorld!.toJson();
    }
    return data;
  }
}

class DreamWorld {
  String? frontDefault;

  DreamWorld({this.frontDefault});

  DreamWorld.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    return data;
  }
}
