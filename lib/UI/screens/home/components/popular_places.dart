import 'package:flutter/material.dart';
import 'package:sistem_de_recomandare/UI/components/place_card.dart';
import 'package:sistem_de_recomandare/UI/components/section_title.dart';
import 'package:sistem_de_recomandare/UI/models/TravelSpot.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Popular Places",
          press: () {},
        ),
        VerticalSpacing(of: 20),
        SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                travelSpots.length,
                    (index) => Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(kDefaultPadding)),
                  child: PlaceCard(
                    travelSport: travelSpots[index],

                    press: () {},
                  ),
                ),
              ),

              SizedBox(
                width: getProportionateScreenWidth(kDefaultPadding),
              ),
            ],
          ),

        ),
      ],
    );
  }
}