import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:majoo_star_wars/presentation/config/theme/constant_styling.dart';
import 'package:majoo_star_wars/presentation/page/login/page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> _info = ['', '', ''];

  void _init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _info = sharedPreferences.getStringList('user')!;

    setState(() {});
  }

  void _handleSignOut() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      await _googleSignIn.signOut();

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setStringList('user', []);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _init();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70,
          backgroundImage: CachedNetworkImageProvider(_info[2]),
        ),
        SizedBox(height: 8),
        Text(
          _info[0],
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          _info[1],
        ),
        SizedBox(height: 32),
        Parent(
          style: ParentStyle()
            ..padding(horizontal: 40, vertical: 12)
            ..background.color(aRed)
            ..borderRadius(all: 5)
            ..ripple(true),
          gesture: Gestures()
            ..onTap(() => _handleSignOut()),
          child: Text(
            'Logout',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 64),
      ],
    );
  }
}
