import 'package:flutter/material.dart';
import 'package:sistem_de_recomandare/UI/components/app_bar.dart';
import 'package:sistem_de_recomandare/UI/components/custom_bottom_nav_bar.dart';
import 'package:sistem_de_recomandare/UI/screens/home/components/body.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../dashboard.dart';
import '../../../plan.dart';
import '../../../recomandationPage.dart';
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
              decoration: BoxDecoration(color: const Color(0xb7059bc9)),
              accountName: Text(
                "Jugănaru Daniela",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "j.daniela@gmail.com",
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
              title: const Text('Trip plan Generator'),
              onTap: () {
                navigateToNextActivity2(context);
                },
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.train,
            //   ),
            //   title: const Text('Page 2'),
            //   onTap: () {
            //    // navigateToNextActivity3(context);
            //   },
            // ),
            AboutListTile( // <-- SEE HERE
              icon: Icon(
                Icons.info,
              ),
              child: Text('About app'),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'Trip plan',
              applicationVersion: '1.0.25',
              applicationLegalese: '© 2022 Company',
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
  navigateToNextActivity2(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => FirstTripInfo()
        )
    );
  }
//   navigateToNextActivity3(BuildContext context) {
//     Navigator.of(context).push(
//         MaterialPageRoute(
//             builder: (context) => Plan()
//         )
//     );
//   }
 }