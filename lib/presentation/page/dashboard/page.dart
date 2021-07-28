import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majoo_star_wars/data/repository/people/local_people_repository_impl.dart';
import 'package:majoo_star_wars/data/repository/people/remote_people_repository_impl.dart';
import 'package:majoo_star_wars/presentation/bloc/people_bloc.dart';
import 'package:majoo_star_wars/presentation/page/dashboard/widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PeopleBloc? _peopleBloc;

  bool _onClickBack() {
    bool back = false;

    showDialog(
        context: context,
        builder: (context) {
          if (Platform.isAndroid) {
            return AlertDialog(
              title: Text(
                'Exit App',
              ),
              content: Text(
                'Are you sure you want to exit the app?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    back = true;
                  },
                  child: Text(
                    "Exit App",
                    style: Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          } else if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text(
                'Exit App',
              ),
              content: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Are you sure you want to exit the app?',
                    style: TextStyle(height: 1.2),
                  ),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    back = true;
                  },
                  isDefaultAction: true,
                  child: Text(
                    "Exit App",
                    style: Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        });

    return back;
  }
  @override
  void initState() {
    super.initState();

    _peopleBloc = BlocProvider.of<PeopleBloc>(context);
    _peopleBloc!.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _peopleBloc,
      listener: _peopleListener,
      child: WillPopScope(
        onWillPop: () async => _onClickBack(),
        child: DefaultTabController(
          length: 3,
          child: SafeArea(
            child: Scaffold(
              body: BlocBuilder<PeopleBloc, PeopleState>(
                bloc: _peopleBloc,
                builder: (context, state) {
                  if (state is PeopleLoadingState) {
                    return PeopleLoadingView();
                  }
                  if (state is PeopleReadyState) {
                    return PeopleReadyView(people: state.people);
                  }
                  if (state is PeopleErrorState) {
                    return PeopleErrorView(error: state.message);
                  }
                  return Center(child: Text('Unknown Error'));
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Future<void> _peopleListener(BuildContext context, PeopleState state) async {
  print('Loading $state');

  if (state is PeopleLoadingState) {

  }

  print('CHECKED PEOPLE');
}
