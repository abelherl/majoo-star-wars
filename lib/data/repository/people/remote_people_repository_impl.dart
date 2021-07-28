import 'package:dartz/dartz.dart';
import 'package:majoo_star_wars/data/datasource/people/remote_people_data_source.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:majoo_star_wars/domain/repository/remote_people_repository.dart';

class RemotePeopleRepositoryImpl extends RemotePeopleRepository {
  @override
  Future<Either<String, List<People>>> getAll() async {
    final result = await PeopleRemoteDataSourceImpl().getAll();
    List<People> peoples = [];
    bool fail = true;
    String failure = '';

    result.fold((l) => failure = l, (r) {
      fail = false;
      peoples = r;
    });

    return fail ? Left(failure) : Right(peoples);
  }
}