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
  List<String> images = [
    "assets/icons/road.png",
    "assets/icons/fly.png",
    "assets/icons/hotel.png",
    "assets/icons/tourist.png",
    "assets/icons/tourist.png",
    "assets/icons/budget.png",
  ];
  List<String> images1 = [
    "assets/icons/road.png",
    "assets/icons/fly.png",
    "assets/icons/hotel.png",
    "assets/icons/tourist.png",
    "assets/icons/tourist.png",
    "assets/icons/budget.png",
  ];
  @override
  void initState() {
    air=widget.airport.name.toString();
    List<String> images = [
      "assets/icons/road.png",
      "assets/icons/fly.png",
      "assets/icons/hotel.png",
      "assets/icons/tourist.png",
      "assets/icons/tourist.png",
      "assets/icons/tourist.png",
    ];
    List<List<String>> allLists=[] ;
    super.initState();

  }
  _bugetFunction(String cost1,String cost2,String cost3,String cost4,String cost5, ){
    double buget;
    if(cost2!=null){
    buget=double.parse(cost1)+double.parse(cost2)+double.parse(cost3)+double.parse(cost4)+double.parse(cost5);
    }else{
      buget=double.parse(cost1)+double.parse(cost3)+double.parse(cost4)+double.parse(cost5);

    }
    return buget;
  }



  List<List<String>> res(){
    double buget=_bugetFunction(widget.airport.cost,widget.fly.cost,widget.hotel.cost,widget.activity1.cost,widget.activity2.cost);

    List<List<String>> allLists=[];
    print("FFFFFFFFFFFFFFFFFFFFFFFFFFFs");
    print(widget.fly.origin);
    if(widget.fly.origin!=null) {
      allLists = [
        [
          "Road",
          widget.airport.origin,
          widget.airport.destination,
          // widget.airport.distance,
          widget.airport.durationA,
          widget.airport.cost,
        ],
        [
          "Flight",
          widget.fly.origin,
          widget.fly.destination,
          widget.fly.duration,
          widget.fly.cost,
          " ",

        ],
        [
          "Acommodation",
          widget.hotel.name,
          " ",
          widget.hotel.cost,
          " ",
          " ",

        ],
        [
          "Activity",
          widget.activity1.name,
          " ",
          widget.activity1.cost,
          " ",
          " ",
        ],
        [
          "Activity",
          widget.activity2.name,
          " ",
          widget.activity2.cost,
          " ",
          " "
        ],
        [
          "Budget",
          " "
              " ",
          " ",
          buget.toStringAsFixed(2),
          " ",


        ]
      ];
    }else{
      allLists = [
        [
          "Road",
          widget.airport.origin,
          widget.airport.destination,
          // widget.airport.distance,
          widget.airport.durationA,
          widget.airport.cost,
        ],
        [
          "Flight",
          "-",
          "-",
          "-",
          "0",
          "-"

        ],
        [
          "Acommodation",
          widget.hotel.name,
          " ",
          widget.hotel.cost,
          " ",
          " ",

        ],
        [
          "Activity",
          widget.activity1.name,
          " ",
          widget.activity1.cost,
          " ",
          " ",
        ],
        [
          "Activity",
          widget.activity2.name,
          " ",
          widget.activity2.cost,
          " ",
          " "
        ],
        [
          "Budget",
          " "
              " ",
          " ",
          buget.toStringAsFixed(2),
          " ",


        ]
      ];
    }
    return allLists;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Your trip plan"),
        ),

        body: ListView.builder(

         itemCount: images1.length,
          key: UniqueKey(),
          itemBuilder: (BuildContext, index){
            var result=res();
            return
              Card(
                child:ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
                  title: Text(result[index][0]),
                  subtitle: Text(result[index][1]+"  "+result[index][2] +"\n"+result[index][3] +"\n"+result[index][4]+" EUR"),
                )
              );
          },

          // separatorBuilder: (BuildContext,index)
          // {
          //   return Divider(height: 30);
          // },
          //itemCount: 6,
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
        )
    );
  }
}