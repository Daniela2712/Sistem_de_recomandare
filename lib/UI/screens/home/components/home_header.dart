import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'search_fields.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenWidth(25)),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/bg.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: getProportionateScreenHeight(315),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(80)),
              Text(
                "Trip Plan",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(68),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,),
              ),
              Text(
                "Travel smart with Trip Plan",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Positioned(
            bottom: getProportionateScreenWidth(-25),
            child: SearchField(),
          )
        ],
      ),
    );
  }
}