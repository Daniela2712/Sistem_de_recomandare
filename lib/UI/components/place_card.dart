import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sistem_de_recomandare/UI/models/User.dart';
import '../size_config.dart';
import '../constants.dart';
import '../models/TravelSpot.dart';

class PlaceCard extends StatelessWidget {
   PlaceCard({
    Key key,
    @required this.travelSport,
    this.isFullCard = false,
    @required this.press,
  }) : super(key: key);

  double _userRating = 3.4;
  double _initialRating = 2.0;
  bool _isVertical = false;

  IconData _selectedIcon;

  final TravelSpot travelSport;
  final bool isFullCard;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(isFullCard ? 158 : 137),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: isFullCard ? 1.09 : 1.29,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                    image: AssetImage(travelSport.image), fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            width: getProportionateScreenWidth(isFullCard ? 158 : 137),
            padding: EdgeInsets.all(
              getProportionateScreenWidth(kDefaultPadding),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [kDefualtShadow],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text(
                  travelSport.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isFullCard ? 17 : 12,
                  ),
                ),
                if (isFullCard)

                SizedBox(height: 40.0),
                RatingBarIndicator(
                  rating: _userRating,
                  itemBuilder: (context, index) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 16.0,
                  unratedColor: Colors.amber.withAlpha(60),
                  direction: _isVertical ? Axis.vertical : Axis.horizontal,
                ),
                VerticalSpacing(of: 10),
                Travelers(
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Travelers extends StatelessWidget {
  const Travelers({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenWidth(30),
      child: Stack(
        alignment: Alignment.center,
        children: [

          // Positioned(
          //   child: Container(
          //     height: getProportionateScreenWidth(28),
          //     width: getProportionateScreenWidth(28),
          //     decoration: BoxDecoration(
          //       color: kPrimaryColor,
          //       shape: BoxShape.circle,
          //     ),
          //     child: Text("Details"),
          //   ),
          // )
        ],
      ),
    );
  }
}