import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:majoo_star_wars/presentation/config/theme/constant_styling.dart';
import 'package:majoo_star_wars/presentation/page/favorites/page.dart';
import 'package:majoo_star_wars/presentation/page/home/page.dart';
import 'package:majoo_star_wars/presentation/page/profile/page.dart';

class PeopleReadyView extends StatefulWidget {
  const PeopleReadyView({
    Key? key,
    required this.people
  }) : super(key: key);

  final List<People> people;

  @override
  _PeopleReadyViewState createState() => _PeopleReadyViewState();
}

class _PeopleReadyViewState extends State<PeopleReadyView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5,),
              child: Center(
                child: Image(
                  image: AssetImage('assets/media/starwars.png'),
                  height: 60,
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(people: widget.people),
                FavoritesPage(people: widget.people,),
                ProfilePage(),
              ],
            ),
          ),
          Theme(
            data: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: TabBar(
              labelColor: Colors.black,
              labelStyle: Theme.of(context).textTheme.bodyText2,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: aRed,
              indicatorWeight: 3,
              tabs: [
                Tab(
                    icon: Icon(Icons.home_rounded)
                ),
                Tab(
                    icon: Icon(Icons.star_rounded)
                ),
                Tab(
                    icon: Icon(Icons.person_rounded)
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class PeopleLoadingView extends StatelessWidget {
  const PeopleLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SpinKitRipple(
                color: Colors.blueGrey,
                size: 120,
              ),
              Image(
                image: AssetImage('assets/media/starwars.png'),
                height: 60,
              ),
            ],
          ),
          Text("This might take a few minutes...")
        ],
      ),
    );
  }
}

class PeopleErrorView extends StatelessWidget {
  const PeopleErrorView({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}


