import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:majoo_star_wars/domain/repository/local_people_repository.dart';
import 'package:majoo_star_wars/domain/repository/remote_people_repository.dart';
import 'package:majoo_star_wars/helper/connection.dart';

abstract class PeopleState {
  @override
  List<Object> get props => [];
}

/// Initial State
class PeopleInitialState extends PeopleState {}

class PeopleLoadingState extends PeopleState {}

class PeopleLocalLoadedState extends PeopleState {
  final List<People> people;

  PeopleLocalLoadedState(this.people);

  @override
  List<Object> get props => [people];
}

class PeopleLocalEmptyState extends PeopleState {}

class PeopleLocalSavedState extends PeopleState {}

class PeopleReadyState extends PeopleState {
  final List<People> people;

  PeopleReadyState(this.people);

  @override
  List<Object> get props => [people];
}

class PeopleErrorState extends PeopleState {
  final String message;

  PeopleErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PeopleBloc extends Cubit<PeopleState> {
  final RemotePeopleRepository remotePeopleRepository;
  final LocalPeopleRepository localPeopleRepository;

  PeopleBloc({
    required this.remotePeopleRepository,
    required this.localPeopleRepository,
  }) : super(PeopleInitialState());

  void initialize() {
    emit(PeopleInitialState());
  }

  void loading() {
    emit(PeopleLoadingState());
  }

  Future<void> init() async {
    loading();

    Either<String, List<People>> result = await remotePeopleRepository.getAll();

    PeopleState state = result.fold((failure) {
        return PeopleErrorState(failure);
      }, (people) {
        print('GETTING ALL DAMMIT ${people[0].name}');
        saveAll(people);
        return PeopleReadyState(people);
      },
    );

    emit(state);
  }

  Future<void> getAll() async {
    loading();
    Either<String, List<People>> result = await localPeopleRepository.getAll();
    PeopleState state = result.fold(
          (failure) {
        return PeopleErrorState(failure);
      },
          (people) {
        print('GETTING ALL DAMMIT LOCALLY ${people[0].name}');
        return PeopleReadyState(people);
      },
    );

    emit(state);
  }

  Future<void> saveAll(List<People> people) async {
    loading();
    final result = await localPeopleRepository.saveAll(people);
    PeopleState state = result.fold(
          (failure) {
        return PeopleErrorState(failure);
      },
          (_) {
        return PeopleReadyState(people);
      },
    );

    emit(state);
  }
}
