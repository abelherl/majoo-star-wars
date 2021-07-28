import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:majoo_star_wars/domain/entity/people.dart';
import 'package:majoo_star_wars/presentation/config/theme/constant_styling.dart';
import 'package:majoo_star_wars/presentation/page/people/page.dart';

class PeopleGridView extends StatefulWidget {
  const PeopleGridView({
    Key? key,
    required this.people,
    required this.peopleList,
  }) : super(key: key);

  final People people;
  final List<People> peopleList;

  @override
  _PeopleGridViewState createState() => _PeopleGridViewState();
}

class _PeopleGridViewState extends State<PeopleGridView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8,),
      child: Parent(
        style: ParentStyle()
          ..background.color(Colors.white)
          ..padding(all: 8, bottom: 5)
          ..borderRadius(all: 12)
          ..boxShadow(color: Colors.black12, blur: 8)
          ..ripple(true),
        gesture: Gestures()
          ..onTap(() => Navigator.push(context, MaterialPageRoute(builder: (context) => PeoplePage(people: widget.people, peopleList: widget.peopleList,)))),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image(
                  image: AssetImage(widget.people.gender.toLowerCase() == 'male' ? 'assets/media/male.png' : (widget.people.gender.toLowerCase() == 'female') ? 'assets/media/female.png' : 'assets/media/droid.png'),
                  color: widget.people.gender.toLowerCase() == 'male' ? Colors.blue.shade300 : (widget.people.gender.toLowerCase() == 'female') ? Colors.red.shade300 : Colors.blueGrey.shade300,
                  height: 40,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  widget.people.name,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PeopleListView extends StatefulWidget {
  const PeopleListView({
    Key? key,
    required this.people
  }) : super(key: key);

  final People people;

  @override
  _PeopleListViewState createState() => _PeopleListViewState();
}

class _PeopleListViewState extends State<PeopleListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5,),
      child: Parent(
        style: ParentStyle()
          ..background.color(Colors.white)
          ..padding(all: 10)
          ..borderRadius(all: 8)
          ..boxShadow(color: Colors.black12, blur: 10)
          ..ripple(true),
        child: Row(
          children: [
            Image(
              image: AssetImage(widget.people.gender.toLowerCase() == 'male' ? 'assets/media/male.png' : (widget.people.gender.toLowerCase() == 'female') ? 'assets/media/female.png' : 'assets/media/droid.png'),
              color: widget.people.gender.toLowerCase() == 'male' ? Colors.blue.shade300 : (widget.people.gender.toLowerCase() == 'female') ? Colors.red.shade300 : Colors.blueGrey.shade300,
              height: 30,
            ),
            SizedBox(width: 10),
            Text(
              widget.people.name,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}


class MyIconButton extends StatefulWidget {
  const MyIconButton({
    Key? key,
    required this.icon,
    required this.onClick,
    required this.size,
    required this.active,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final Function onClick;
  final double size;
  final bool active;
  final Color color;

  @override
  _MyIconButtonState createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  bool _active = false;

  @override
  void initState() {
    _active = widget.active;
    super.initState();
  }

  void _onClick() {
    widget.onClick();

    print("Clicked");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onClick(),
      child: Icon(
        widget.icon,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}

