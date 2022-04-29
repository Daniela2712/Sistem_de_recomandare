import 'package:flutter/material.dart';
import 'package:sistem_de_recomandare/UI/components/app_bar.dart';
import 'package:sistem_de_recomandare/UI/components/custom_bottom_nav_bar.dart';
import 'package:sistem_de_recomandare/UI/screens/home/components/body.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constants.dart';
import '../user_profile/pages/profile_page.dart';

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
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: const Color(0xffac98b5)),
              accountName: Text(
                "Pinkesh Darji",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "pinkesh.earth@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            AboutListTile( // <-- SEE HERE
              icon: Icon(
                Icons.info,
              ),
              child: Text('About app'),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'My Cool App',
              applicationVersion: '1.0.25',
              applicationLegalese: '© 2019 Company',
              aboutBoxChildren: [
                ///Content goes here...
              ],
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
            onPressed: () {
              navigateToNextActivity(context);
            },
          )
        ],
      ),

      body: Body(),

      bottomNavigationBar: CustomBottonNavBar(),
    );
  }
  navigateToNextActivity(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ProfilePage()

        )
    );
  }
}