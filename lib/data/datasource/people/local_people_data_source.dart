import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class PeopleLocalDataSource {
  PeopleLocalDataSource._();
  static final PeopleLocalDataSource db = PeopleLocalDataSource._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null)
      return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'glovory_mart.db'),
      onCreate: (db, version) async {
        await db.execute('''         
          CREATE TABLE people (
            id TEXT PRIMARY KEY, 
            name TEXT,
            height TEXT,
            hair_color TEXT,
            skin_color TEXT,
            eye_color TEXT,
            birth_year TEXT,
            gender TEXT,
            films TEXT,
            species TEXT,
            favorite TEXT
          )
        ''');
      },
      version: 9,
    );
  }

  newPeople(People newPeople) async {
    final db = await database;

    var res = await db.rawInsert('''
      INSERT INTO people (
        id, name, height, hair_color, skin_color, eye_color, birth_year, gender, films, species, favorite
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [newPeople.id, newPeople.name, newPeople.height, newPeople.hairColor, newPeople.skinColor, newPeople.eyeColor, newPeople.birthYear, newPeople.gender, newPeople.films, newPeople.species, newPeople.favorite]);

    return res;
  }

  Future<List<People>> getPeoples() async {
    final db = await database;
    var res = await db.query("people");
    List<People> people = [];

    res.forEach((element) {
      people.add(People(
        id: element["id"].toString(),
        name: element["name"].toString(),
        height: element["height"].toString(),
        hairColor: element["hair_color"].toString(),
        skinColor: element["skin_color"].toString(),
        eyeColor: element["eye_color"].toString(),
        birthYear: element["birth_year"].toString(),
        gender: element["gender"].toString(),
        films: element["films"].toString(),
        species: element["species"].toString(),
        favorite: element["favorite"].toString()
      ));
    });

    if (res.length == 0) {
      return [];
    }
    else {
      return people;
    }
  }

  deletePeoples() async {
    final db = await database;
    db.delete("people");
  }
}