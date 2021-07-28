import 'package:flutter/material.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:majoo_star_wars/presentation/config/theme/constant_styling.dart';
import 'package:majoo_star_wars/presentation/page/home/widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key,
    required this.people
  }) : super(key: key);

  final List<People> people;

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<People>? _people;
  List<People>? _initialPeople;
  bool _sortAsc = false;
  bool _gridView = false;

  void _onSortClick() {
    _sortAsc = !_sortAsc;

    if (_sortAsc) {
      _people!.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    }
    else {
      _people!.sort((a, b) {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      });
    }

    print(_sortAsc);

    setState(() {});
  }

  void _onGridViewClick() {
    _gridView = !_gridView;
    print("GridView: $_gridView");

    setState(() {});
  }

  void _onSearch(String string) {
    _people = _initialPeople!.where((element) => element.name.toLowerCase().contains(string.toLowerCase())).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initialPeople = widget.people.where((element) => element.favorite == 'yes').toList();
    _people = _initialPeople;
    _onSortClick();
    _onGridViewClick();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.search,
                    onChanged: (string) => _onSearch(string),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'Search',
                      hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.search_rounded, size: 29,),
                SizedBox(width: 15),
                MyIconButton(
                  icon: Icons.grid_view_rounded,
                  onClick: () => _onGridViewClick(),
                  active: _gridView,
                  size: 25,
                  color: _gridView ? aRed : Colors.black,
                ),
                SizedBox(width: 5),
                Container(
                  height: 25,
                  width: 2,
                  color: Colors.black38,
                ),
                SizedBox(width: 4),
                MyIconButton(
                  icon: Icons.view_headline_rounded,
                  onClick: () => _onGridViewClick(),
                  active: !_gridView,
                  size: 29,
                  color: !_gridView ? aRed : Colors.black,
                ),
                SizedBox(width: 10),
                MyIconButton(
                  icon: Icons.sort_by_alpha_rounded,
                  onClick: () => _onSortClick(),
                  active: _sortAsc,
                  size: 29,
                  color: _sortAsc ? aRed : Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: _people!.length == 0 ? Center(child: Text("No Favorites")) : _gridView ? GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
              ),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 10, left: 4, right: 4,),
              children: _people!.map((element) => PeopleGridView(people: element, peopleList: _initialPeople!,)).toList(),
            ) :
            ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 10),
              children: _people!.map((element) => PeopleListView(people: element)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
