import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistem_de_recomandare/nodeClass.dart';
import 'package:sistem_de_recomandare/plan.dart';
import 'package:sistem_de_recomandare/service/airport_service.dart';
import 'package:sistem_de_recomandare/httpTest.dart';
import 'package:sistem_de_recomandare/service/drive_service.dart';
import 'package:sistem_de_recomandare/service/transit_service.dart';
import 'package:sistem_de_recomandare/service/tronson_service.dart';
import 'package:uuid/uuid.dart';

import 'service/activities_service.dart';
import 'service/bestTransit_service.dart';
import 'dropdown.dart';
import 'service/fly_service.dart';
import 'service/hotel_service.dart';
import 'model/database_manager.dart';
import 'model/service_locator.dart';

Node airport =new Node();
Node fly =new Node();
Node hotel =new Node();
Node activity1 =new Node();
Node activity2 =new Node();

class UserForm extends StatefulWidget {
 // UserForm({Key key}) : super(key: key);
   final String origin;
   final String destination;
   final String departure_date;
   final String trip_name;

   UserForm(this.trip_name, this.origin, this.destination, this.departure_date);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _checkInController = TextEditingController();
  final _checkOutController = TextEditingController();
  final _roomQtyController = TextEditingController();
  final

  _nrAdultsController = TextEditingController();


  String checkIn_date ='';
  String checkOut_date ='';
  String roomQty ='';
  String nrAdults ='';


  DateTime selectedDate = DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  @override
  void dispose() {
    _checkInController.dispose();
    _checkOutController.dispose();
    _roomQtyController.dispose();
    _nrAdultsController.dispose();
    super.dispose();
  }

  _submitForm(String checkIn_date, String checkOut_date,String nrAdults, String roomQty) {
    if (_formKey.currentState.validate()) {

     final sessionToken = Uuid().v4();
        httpService().postServerInfo(widget.trip_name,  widget.origin, widget.destination, widget.departure_date, checkIn_date, checkOut_date, nrAdults, roomQty);
    }
  }
  bool _isLoading=false;
  void _startLoading() async {
    setState(() {
      _isLoading = true;
    });
    print(_isLoading);

    var result= await httpService().postServerInfo(widget.trip_name,  widget.origin, widget.destination, widget.departure_date, checkIn_date,checkOut_date,_nrAdultsController.text,_roomQtyController.text);

    print("RESUUUUUUUUUULTTTTTTTTT");
    print(result[1]);
   // await Future.delayed(Duration(seconds: 180));

    setState(() {
      _isLoading = false;
      airport=result[0];
      fly=result[1];
      hotel=result[2];
      activity1=result[3];
      activity2=result[4];
    });
    print("HOOOOOOTTTTEEEEELLLLLLLL");
    print(hotel.name);
    navigateToNextActivity2(context);
    print(_isLoading);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip info"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Column(children: <Widget>[
                  TextField(
                      controller: _checkInController, //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter check-in date" //label text of field
                      ),
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () {
                        _selectDate(context);
                      }
                    //     Text("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}")
                  )
                ]
                ),
                Column(children: <Widget>[
                  TextField(
                      controller: _checkOutController, //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter check-out date" //label text of field
                      ),
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () {
                        _selectDate2(context);
                      }
                    //     Text("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}")
                  )
                ]
                ),

                TextFormField(
                  controller: _nrAdultsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter number of adults',
                      labelText: 'Number of adults',
                      contentPadding: EdgeInsets.all(10.0)
                  ),
                ),
                TextFormField(
                  controller: _roomQtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter room quantity',
                      labelText: 'Room quantity',
                      contentPadding: EdgeInsets.all(10.0)
                  ),
                ),

                Row(
                    children:[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5
                          ),
                          child: ElevatedButton.icon(
                            icon: _isLoading ? CircularProgressIndicator(): Text(""),
                            label: Text(
                              _isLoading ? 'Loading...' : 'Submit',
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: _isLoading ? null : _startLoading,
                            style: ElevatedButton.styleFrom(fixedSize: Size(100, 20)),
                          ),
                          // child: ElevatedButton(
                          //   onPressed: ()  {
                          //     setState(() {
                          //       _isLoading=true;
                          //     });
                          //     _submitForm(checkIn_date,checkOut_date,_nrAdultsController.text,_roomQtyController.text);
                          //     setState(() {
                          //       _isLoading=false;
                          //     });
                          //     SizedBox(
                          //       height: 20.0,
                          //     );
                          //
                          //   },
                          //   child: Text('Submit'),
                          // ),
                        ),
                      ),
                      // Container(
                      //   child: Center(
                      //     child: !_isLoading
                      //         ? navigateToNextActivity(context)
                      //         :const CircularProgressIndicator(),
                      //   ),
                      // )
                    ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    NumberFormat formatter = new NumberFormat("00");
    if (selected != null && selected != selectedDate)

    setState(() {
        _checkInController.text = "${selectedDate.year}-${formatter.format(selectedDate.month)}-${formatter.format(selectedDate.day)}";
        checkIn_date=_checkInController.text;
        selectedDate=selected;
      });
  }
  _selectDate2(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    NumberFormat formatter = new NumberFormat("00");
    if (selected != null && selected != selectedDate)

    setState(() {
        _checkOutController.text = "${selectedDate.year}-${formatter.format(selectedDate.month)}-${formatter.format(selectedDate.day)}";
        checkOut_date=_checkOutController.text;
        selectedDate=selected;
      });
  }
  navigateToNextActivity(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => UserForm(checkIn_date,checkOut_date,nrAdults,roomQty)
        )
    );
  }
  navigateToNextActivity2(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => Plan(airport, fly, hotel, activity1, activity2)
        )
    );
  }
}