import 'package:flutter/material.dart';
import 'package:sistem_de_recomandare/model/database_manager.dart';
import 'package:sistem_de_recomandare/model/service_locator.dart';
import 'package:sistem_de_recomandare/custom_textfield.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final usernameController = TextEditingController();
  final mailController = TextEditingController();
  final countryController = TextEditingController();
  final languageController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    mailController.dispose();
    countryController.dispose();
    languageController.dispose();

    super.dispose();
  }

  void createUser(
      {String username, String mail, String country, String language}) async {
    User user = User(
        id: null,
        username: username,
        mail: mail,
        country: country,
        language: language);

    await locator<UserDatabase>().insertUser(user);
  }

  @override
  Widget build(BuildContext context) {
    final _username = Padding(
        padding:
        EdgeInsets.only(top: 0.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: CustomTextField(
          hintText: 'Username',
          controller: usernameController,
        ));

    final _mail = Padding(
        padding:
        EdgeInsets.only(top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: CustomTextField(
          hintText: 'Mail',
          controller: mailController,
        ));

    final _country = Padding(
        padding:
        EdgeInsets.only(top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: CustomTextField(
          hintText: 'Country',
          controller: countryController,
        ));

    final _language = Padding(
        padding:
        EdgeInsets.only(top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: CustomTextField(
          hintText: 'Language',
          controller: languageController,
        ));

    final _createButton = Padding(
      padding: EdgeInsets.only(top: 50.0, bottom: 0.0, right: 50.0, left: 50.0),
      child: RaisedButton(
        onPressed: () => createUser(
            username: usernameController.text,
            mail: mailController.text,
            country: countryController.text,
            language: languageController.text),
        child: const Text('Add User', style: TextStyle(fontSize: 20)),
      ),
    );

    final _screen = Material(
        color: Colors.transparent,
        child: new Container(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_username, _mail, _country, _language, _createButton]),
        ));

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Center(
              child: _screen,
            ),
          ),
        ),
      ),
    );
  }
}