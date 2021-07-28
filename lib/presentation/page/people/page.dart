import 'dart:io' show Platform;

import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majoo_star_wars/data/repository/people/local_people_repository_impl.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:majoo_star_wars/presentation/config/theme/constant_styling.dart';
import 'package:majoo_star_wars/presentation/page/dashboard/page.dart';
import 'package:majoo_star_wars/presentation/page/people/widget.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({
    Key? key,
    required this.peopleList,
    required this.people,
  }) : super(key: key);

  final List<People> peopleList;
  final People people;

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  People? _people;
  List<People> _peopleList = [];

  void _deleteItem() async {
    _peopleList.removeWhere((element) => element.id == _people!.id);

    await LocalPeopleRepositoryImpl().saveAll(_peopleList);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPage()), (_) => false);
  }

  void _updateItem() async {
    _peopleList.removeWhere((element) => element.id == _people!.id);
    _peopleList.add(_people!);

    await LocalPeopleRepositoryImpl().saveAll(_peopleList);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPage()), (_) => false);
  }

  void _onClickDelete() {
    showDialog(
        context: context,
        builder: (context) {
          if (Platform.isAndroid) {
            return AlertDialog(
              title: Text(
                'Delete Item',
              ),
              content: Text(
                'Are you sure you want to delete this item?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => _deleteItem(),
                  child: Text(
                    "Delete Item",
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
                'Delete Item',
              ),
              content: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Are you sure you want to delete this item?',
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
                  onPressed: () => _deleteItem(),
                  isDefaultAction: true,
                  child: Text(
                    "Delete Item",
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
  }
  void _onClickUpdate() {
    showDialog(
        context: context,
        builder: (context) {
          if (Platform.isAndroid) {
            return AlertDialog(
              title: Text(
                'Update Item',
              ),
              content: Text(
                'Are you sure you want to update this item?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => _updateItem(),
                  child: Text(
                    "Update Item",
                    style: Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            );
          } else if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text(
                'Update Item',
              ),
              content: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Are you sure you want to update this item?',
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
                  onPressed: () => _updateItem(),
                  isDefaultAction: true,
                  child: Text(
                    "Update Item",
                    style: Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        });
  }
  bool _onClickBack() {
    bool back = false;

    showDialog(
        context: context,
        builder: (context) {
          if (Platform.isAndroid) {
            return AlertDialog(
              title: Text(
                'Discard Changes',
              ),
              content: Text(
                'Are you sure you want to discard changes to this item?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    back = true;
                  },
                  child: Text(
                    "Discard Changes",
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
                'Discard Changes',
              ),
              content: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Are you sure you want to discard changes to this item?',
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
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    back = true;
                  },
                  isDefaultAction: true,
                  child: Text(
                    "Discard Changes",
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

    _people = widget.people;
    _peopleList = widget.peopleList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onClickBack(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 10,
          actions: [
            IconButton(
                onPressed: () => _onClickDelete(),
                icon: Icon(Icons.delete_rounded))
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextField(
                    title: 'Name',
                    initialValue: _people!.name,
                    onChanged: (string) {
                      _people!.name = string;
                    },
                  ),
                  MyTextField(
                    title: 'Height',
                    initialValue: _people!.height,
                    onChanged: (string) {
                      _people!.height = string;
                    },
                  ),
                  MyTextField(
                    title: 'Hair Color',
                    initialValue: _people!.hairColor,
                    onChanged: (string) {
                      _people!.hairColor = string;
                    },
                  ),
                  MyTextField(
                    title: 'Skin Color',
                    initialValue: _people!.skinColor,
                    onChanged: (string) {
                      _people!.skinColor = string;
                    },
                  ),
                  MyTextField(
                    title: 'Eye Color',
                    initialValue: _people!.eyeColor,
                    onChanged: (string) {
                      _people!.eyeColor = string;
                    },
                  ),
                  MyTextField(
                    title: 'Birth Year',
                    initialValue: _people!.birthYear,
                    onChanged: (string) {
                      _people!.birthYear = string;
                    },
                  ),
                  MyTextField(
                    title: 'Gender',
                    initialValue: _people!.gender,
                    onChanged: (string) {
                      _people!.gender = string;
                    },
                  ),
                  MyTextField(
                    title: 'Films',
                    initialValue: _people!.films,
                    onChanged: (string) {
                      _people!.species = string;
                    },
                  ),
                  MyTextField(
                    title: 'Species',
                    initialValue: _people!.species,
                    onChanged: (string) {
                      _people!.species = string;
                    },
                  ),
                  SizedBox(height: 70),
                  Parent(
                    style: ParentStyle()
                      ..padding(vertical: 12)
                      ..width(10000)
                      ..background.color(Colors.teal)
                      ..borderRadius(all: 5)
                      ..ripple(true),
                    gesture: Gestures()
                      ..onTap(() => _onClickUpdate()),
                    child: Center(
                      child: Text(
                        'Update',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
