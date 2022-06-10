import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_de_recomandare/nodeClass.dart';


class Plan extends StatefulWidget {
  //Plan({Key key}) : super(key: key);
  final Node airport;
  final Node fly;
  final Node hotel;
  final Node activity1;
  final Node activity2;

  Plan(this.airport, this.fly, this.hotel, this.activity1, this.activity2);
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  String air;
  @override
  void initState() {
    air=widget.airport.name.toString();
    super.initState();
  }

  List<String> images = [
    "assets/icons/road.png",
    "assets/icons/fly.png",
    "assets/icons/hotel.png",
    "assets/icons/tourist.png",
    "assets/icons/tourist.png",
  ];

  List<List<String>> res(){
    List<List<String>> allLists=[];
    allLists= [
      [
      "Road",
      widget.airport.origin,
      widget.airport.destination,
      widget.airport.distance,
      widget.airport.duration,
      widget.airport.cost,
      ],
      [
        "Flight",
        widget.fly.origin,
        widget.fly.destination,
        widget.fly.duration,
        //"widget.fly.departure_time",
        " ",
        widget.fly.cost,
      ],
      [
      "Acommodation",
      widget.hotel.name,
      //widget.hotel.contact,
       " ",
      " ",
      " ",
     // widget.hotel.checkInDate,
      //widget.hotel.checkOutDate,
      widget.hotel.cost,
      ],
      [
        "Activity",
        widget.activity1.name,
        " ",
        " ",
        " ",
        widget.activity1.cost,
      ],
      [
        "Activity",
        widget.activity2.name,
        " ",
        " ",
        " ",
        widget.activity2.cost,
      ]
    ];
    return allLists;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your trip plan"),
        ),
        body: ListView.separated(

          itemBuilder: (BuildContext, index){

            var result=res();
            return ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
              title: Text(result[index][0]),
              subtitle: Text(result[index][1]+"  "+result[index][2] +"\n"+result[index][3]+"  "+result[index][4] +"\n"+result[index][5]+" RON"),
            );
          },
          separatorBuilder: (BuildContext,index)
          {
            return Divider(height: 40);
          },
          itemCount: images.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
        )
    );
  }
}