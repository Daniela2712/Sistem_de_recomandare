import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sistem_de_recomandare/screens/events/events_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class CustomBottonNavBar extends StatelessWidget {
  const CustomBottonNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // children: [
            //   NavItem(
            //     icon: "assets/icons/calendar.svg",
            //     title: "Events",
            //     press: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => EventsScreen(),
            //           ));
            //     },
            //   ),
            //   NavItem(
            //     icon: "assets/icons/chat.svg",
            //     title: "Chat",
            //     isActive: true,
            //     press: () {},
            //   ),
            //   NavItem(
            //     icon: "assets/icons/friendship.svg",
            //     title: "Friends",
            //     press: () {},
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
}
