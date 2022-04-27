import 'package:flutter/material.dart';
import 'package:sistem_de_recomandare/recomandationPage.dart';

import 'login.dart';
import 'model/database_manager.dart';
import 'model/service_locator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Handling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Registration'),
        ),
        body: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  RegistrationForm({Key key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _submitForm() {
    if (_formKey.currentState.validate()) {
      var user = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      print(user.toString());

      // If the form passes validation, display a Snackbar.
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Registration sent')));
      //_formKey.currentState.save();
      //_formKey.currentState.reset();
      //_nextFocus(_nameFocusNode);
      createUser(user["name"],user["email"],user["phone"],user["password"]);

    }
    navigateToNextActivity(context);

  }

  void createUser(
      String username, String mail, String country, String language) async {
    User user = User(
        id: null,
        username: username,
        mail: mail,
        country: country,
        language: language);

    await locator<UserDatabase>().insertUser(user);
    print("-----------------------------");
    var usrs=await locator<UserDatabase>().getAllUsers();
    print(usrs);
    print("-----------------------------");
  }

  String _validateInput(String value) {
    if(value.trim().isEmpty) {
      return 'Field required';
    }
    return null;
  }

  _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Builder(
        builder: (context) => new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),

            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    TextFormField(
                      focusNode: _nameFocusNode,
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: _validateInput,
                      onFieldSubmitted: (String value) {
                        _nextFocus(_phoneFocusNode);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        labelText: 'Full Name',
                      ),
                    ),
                    TextFormField(
                      focusNode: _phoneFocusNode,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      validator: _validateInput,
                      onFieldSubmitted: (String value) {
                        _nextFocus(_emailFocusNode);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        labelText: 'Phone Number',
                      ),
                    ),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _validateInput,
                      onFieldSubmitted: (String value) {
                        _nextFocus(_passwordFocusNode);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your email address',
                        labelText: 'Email Address',
                      ),
                    ),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: _validateInput,
                      obscureText: _isHidden,
                      onFieldSubmitted: (String value) {
                        _submitForm();
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 16,
                            ),
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: Text('Register'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  navigateToNextActivity(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => LoginScreen()

        )
    );
  }
}
