import 'package:flutter/material.dart';
import 'package:sistem_de_recomandare/components/app_bar.dart';
import 'package:sistem_de_recomandare/components/custom_bottom_nav_bar.dart';
import 'package:sistem_de_recomandare/screens/home/components/body.dart';

import '../../constants.dart';

class HomeScreen extends StatelessWidget {
  bool isTransparent = true;
  String title;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: new Drawer(
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
      ),
      appBar: AppBar(
        backgroundColor: isTransparent ? Colors.transparent : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: kIconColor,
          ),
          onPressed: ()=> _scaffoldKey.currentState.openDrawer(),


        ),
        title: ! isTransparent
            ? Text(
          isTransparent ? "" : title,
          style: TextStyle(color: kTextColor),
        )
            : null,
        centerTitle: true,
        actions: [
          IconButton(
            icon: ClipOval(child: Image.asset("assets/images/profile.png")),
            onPressed: () {},
          )
        ],
      ),
      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text('Drawer Header'),
      //       ),
      //       ListTile(
      //         title: const Text('Item 1'),
      //         onTap: () {
      //           // Update the state of the app
      //           // ...
      //           // Then close the drawer
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Item 2'),
      //         onTap: () {
      //           // Update the state of the app
      //           // ...
      //           // Then close the drawer
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Body(),

      bottomNavigationBar: CustomBottonNavBar(),
    );
  }
}