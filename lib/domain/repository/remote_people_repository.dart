import 'package:dartz/dartz.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';

abstract class RemotePeopleRepository{
  Future<Either<String, List<People>>> getAll();
}