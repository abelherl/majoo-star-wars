import 'package:dartz/dartz.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';

abstract class LocalPeopleRepository {
  Future<Either<String,List<People>>> getAll();
  Future<Either<String, bool>> saveAll(List<People> people);
}