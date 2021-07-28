import 'package:equatable/equatable.dart';

class Species extends Equatable {
  final String id;
  final String name;
  final String classification;
  final String designation;
  final String averageHeight;
  final String skinColors;
  final String hairColors;
  final String eyeColors;
  final String averageLifespan;
  final String language;

  Species({
      required this.id,
      required this.name,
      required this.classification,
      required this.designation,
      required this.averageHeight,
      required this.skinColors,
      required this.hairColors,
      required this.eyeColors,
      required this.averageLifespan,
      required this.language});

  @override
  List<Object> get props => [id];
}
