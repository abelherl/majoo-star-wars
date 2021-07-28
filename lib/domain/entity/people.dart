import 'package:equatable/equatable.dart';
import 'package:majoo_star_wars/domain/entity/species.dart';

import 'film.dart';

class People extends Equatable {
  String id;
  String name;
  String height;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  String films;
  String species;
  String favorite;

  People({
      required this.id,
      required this.name,
      required this.height,
      required this.hairColor,
      required this.skinColor,
      required this.eyeColor,
      required this.birthYear,
      required this.gender,
      required this.films,
      required this.species,
      required this.favorite
  });

  @override
  List<Object> get props => [id];
}
