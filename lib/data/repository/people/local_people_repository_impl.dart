import 'package:dartz/dartz.dart';
import 'package:majoo_star_wars/data/datasource/people/local_people_data_source.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:majoo_star_wars/domain/repository/local_people_repository.dart';

class LocalPeopleRepositoryImpl extends LocalPeopleRepository {
  @override
  Future<Either<String, List<People>>> getAll() async {
    final result = await PeopleLocalDataSource.db.getPeoples();
    List<People> people = result;

    // print("RESEL: ${people[0].name}");

    return Right(people);
  }

  @override
  Future<Either<String, bool>> saveAll(List<People> people) async {
    PeopleLocalDataSource.db.deletePeoples();

    people.forEach((element) async {
      final _ = await PeopleLocalDataSource.db.newPeople(element);
    });

    return Right(true);
  }

}