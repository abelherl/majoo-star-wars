import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:majoo_star_wars/presentation/page/dashboard/page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _setSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('user', [_googleSignIn.currentUser!.displayName!, _googleSignIn.currentUser!.email, _googleSignIn.currentUser!.photoUrl!]);
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();

      print("Success");
      _setSharedPreferences();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
    } catch (error) {
      print(error);
    }
  }

  Future<void> _checkSignedIn() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final info = sharedPreferences.getStringList('user');
      print(info);

      if (info != [] || info != null) {
        print("Redirecting ${info![0]}");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
      }
      else {
        print("Not Logged In");
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _checkSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/media/starwars.png'),
              height: 120,
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () => _handleSignIn(),
            ),
          ],
        ),
      ),
    );
  }
}
