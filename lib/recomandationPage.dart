import 'package:flutter/material.dart';
import 'package:sistem_de_recomandare/airport_service.dart';
import 'package:sistem_de_recomandare/transit_service.dart';
import 'package:sistem_de_recomandare/tronson_service.dart';
import 'package:uuid/uuid.dart';

import 'activities_service.dart';
import 'bestTransit_service.dart';
import 'dropdown.dart';
import 'fly_service.dart';
import 'hotel_service.dart';
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

  final FocusNode _bugetFocusNode = FocusNode();
  final FocusNode _nrPersonsFocusNode = FocusNode();
  final FocusNode _destTypeFocusNode = FocusNode();
  final FocusNode _travelModeFocusNode = FocusNode();

  final TextEditingController _bugetController = TextEditingController();
  final TextEditingController _nrPersonsController = TextEditingController();
  String _destTypeController;
  String _travelModeController;



  _submitForm() {
    if (_formKey.currentState.validate()) {
      final userTravelDetails = {
        'buget': _bugetController.text,
        'NumberOfPersons': _nrPersonsController.text,
        'destinationType': _destTypeController,
        'travelMode': _travelModeController,
      };
     final sessionToken = Uuid().v4();
      //TronsonRouteApiProvider().getNearestAirportFromOrigin("Brasov");
     // BestTransitProvider().bestTransitMode("Brasov","Constanta");
     // TronsonRouteApiProviderForTransit().getTronsonRouteDetailFromOriginAndDestinationWithTrainInternet("Brasov","Sibiu International Airport");
     //TronsonRouteApiProvider().getTronsonRouteDetailFromOriginAndDestinationWithTrainInternet("Brasov","Sibiu International Airport");
          //,"London",userTravelDetails['buget'],userTravelDetails['NumberOfPersons'],userTravelDetails['destinationType'],userTravelDetails['travelMode']);
     // print(userTravelDetails.toString());
      //HotelApiProvider().getDestinationHotelDetail("MAD");
      ActivitiesProviderApi().getActivitiesForMultipleHotelDestinations("MAD");
      //TronsonRouteApiProviderForFly().getRouteDetailFromAirToDestinationWithAir("MAD");
      //ActivitiesProviderApi().getActivitiesListFromDestinationInternet("Barcelona");
      //TronsonRouteApiProviderForTransit().getRouteDetailToRomanianAirportWithTrain("Brasov");
      // If the form passes validation, display a Snackbar.
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Registration sent')));
      //_formKey.currentState.save();
      //_formKey.currentState.reset();
      //_nextFocus(_nameFocusNode);
    }
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
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

                      focusNode: _bugetFocusNode,
                      controller: _bugetController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: _validateInput,
                      onFieldSubmitted: (String value) {
                        _nextFocus(_nrPersonsFocusNode);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your buget',
                        labelText: 'Buget',
                        contentPadding: EdgeInsets.all(10.0)
                      ),
                  ),
                    TextFormField(
                      focusNode: _nrPersonsFocusNode,
                      controller: _nrPersonsController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: _validateInput,
                      onFieldSubmitted: (String value) {
                        _nextFocus(_destTypeFocusNode);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter number of persons',
                        labelText: 'Persons number',
                        contentPadding: EdgeInsets.all(10.0)

                      ),
                  ),

                Container(
                  padding: EdgeInsets.all(0),
                  child: DropDownFormField(
                      titleText: 'Destination type',
                      hintText: 'Please choose one',
                      value: _destTypeController,
                      onSaved: (value) {
                        setState(() {
                          _destTypeController = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _destTypeController = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Intern destination",
                          "value": "Intern",
                        },
                        {
                          "display": "Extern destination",
                          "value": "Extern",
                        },

                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(0),
                    child: DropDownFormField(
                      titleText: 'Travel mode',
                      hintText: 'Please choose one',
                      value: _travelModeController,
                      onSaved: (value) {
                        setState(() {
                          _travelModeController = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _travelModeController = value;
                        });
                      },
                      dataSource: [
                            {
                              "display": "Car",
                              "value": "Drive",
                            },
                            {
                              "display": "Train",
                              "value": "Transit",
                            },
                            {
                              "display": "Airplane",
                              "value": "Fly",
                            },

                          ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5
                          ),
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            child: Text('Submit'),
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
    );
  }
}