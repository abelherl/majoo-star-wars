import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majoo_star_wars/presentation/bloc/people_bloc.dart';
import 'package:majoo_star_wars/presentation/config/theme/main_theme.dart';
import 'package:majoo_star_wars/presentation/page/dashboard/page.dart';
import 'package:majoo_star_wars/presentation/page/login/page.dart';

import 'data/repository/people/local_people_repository_impl.dart';
import 'data/repository/people/remote_people_repository_impl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          print("GESTURE");
          currentFocus.unfocus();
        },
        child: BlocProvider<PeopleBloc>(
          create: (context) => PeopleBloc(
            remotePeopleRepository: RemotePeopleRepositoryImpl(),
            localPeopleRepository: LocalPeopleRepositoryImpl(),
          ),
          child: MaterialApp(
            title: 'Majoo Star Wars',
            theme: mainTheme(),
            home: LoginPage(),
          ),
        ),
      ),
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }
}
