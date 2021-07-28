import 'package:equatable/equatable.dart';

class Film extends Equatable {
  final String id;
  final String title;
  final String director;
  final String producer;
  final String openingCrawl;
  final String releaseDate;

  Film({
      required this.id,
      required this.title,
      required this.director,
      required this.producer,
      required this.openingCrawl,
      required this.releaseDate});

  @override
  List<Object> get props => [id];
}
