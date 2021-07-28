import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:majoo_star_wars/data/datasource/people/local_people_data_source.dart';
import 'package:majoo_star_wars/domain/entity/film.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:majoo_star_wars/domain/entity/species.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PeopleRemoteDataSource {
  Future<Either<String, List<People>>> getAll();
}

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  BaseOptions options = new BaseOptions(
    baseUrl: "https://swapi.dev/api/people",
    connectTimeout: 100000,
    receiveTimeout: 100000,
  );

  @override
  Future<Either<String, List<People>>> getAll() async {
    final Dio client = new Dio(options);

    List<People> peoples = await PeopleLocalDataSource.db.getPeoples();
    List<Species> species = [];
    List<Film> films = [];

    if (peoples.length == 0) {
      bool done = false;
      int i = 1;

      try {
        final response =
        await client.get("https://swapi.dev/api/films/");
        print("RESPONSE: ${response.data}");

        if (response.statusCode == 103) {
          return Left(response.statusMessage!);
        }

        if (response.statusCode == 200) {
          Map<String, dynamic> map = response.data;
          List<dynamic> data = map["results"];

          for (var element in data) {
            print('Adding: ${element["title"]}');

            final item = Film(
              id: element["url"],
              title: element["title"],
              director: '',
              openingCrawl: '',
              producer: '',
              releaseDate: '',
            );

            films.add(item);
          }
        } else {
          return Left(response.statusMessage!);
        }
      } on DioError catch (e) {
        return Left(e.message);
      }

      while (!done) {
        try {
          final response =
              await client.get("https://swapi.dev/api/species/?page=$i");
          print("RESPONSE: ${response.data}");

          if (response.statusCode == 103) {
            return Left(response.statusMessage!);
          }

          if (response.statusCode == 200) {
            Map<String, dynamic> map = response.data;
            List<dynamic> data = map["results"];

            print("RESPONSE: ${map["next"] == null}");

            map["next"] == null ? done = true : i++;

            for (var element in data) {
              print('Adding: ${element["name"]}');

              final item = Species(
                id: element["url"],
                name: element["name"],
                eyeColors: '',
                skinColors: '',
                averageLifespan: '',
                hairColors: '',
                averageHeight: '',
                language: '',
                designation: '',
                classification: '',
              );

              species.add(item);
            }
          } else {
            return Left(response.statusMessage!);
          }
        } on DioError catch (e) {
          return Left(e.message);
        }
      }

      i = 1;
      done = false;

      while (!done) {
        try {
          final response =
              await client.get("https://swapi.dev/api/people/?page=$i");
          print("RESPONSE: ${response.data}");

          if (response.statusCode == 103) {
            return Left(response.statusMessage!);
          }

          if (response.statusCode == 200) {
            Map<String, dynamic> map = response.data;
            List<dynamic> data = map["results"];

            print("RESPONSE: ${map["next"] == null}");

            map["next"] == null ? done = true : i++;

            for (var element in data) {
              print('Adding: ${element["species"]} ${(element["species"] as List).length != 0}');

              String peopleFilm = '';
              String peopleSpecies = (element["species"] as List).length != 0 ? species.where((e) => e.id == element["species"][0]).first.name : '';

              (element["films"] as List).forEach((film) {
                peopleFilm += films.where((e) => e.id == film).first.title + ', ';
              });

              peopleFilm = peopleFilm.substring(0, peopleFilm.length - 2);

              final people = People(
                id: element["url"],
                name: element["name"],
                height: element["height"],
                hairColor: element["hair_color"],
                skinColor: element["skin_color"],
                eyeColor: element["eye_color"],
                birthYear: element["birth_year"],
                gender: element["gender"],
                films: peopleFilm,
                species: peopleSpecies,
                favorite: 'no'
              );

              peoples.add(people);
            }
          } else {
            return Left(response.statusMessage!);
          }
        } on DioError catch (e) {
          return Left(e.message);
        }
      }
    }

    return Right(peoples);
  }
}
