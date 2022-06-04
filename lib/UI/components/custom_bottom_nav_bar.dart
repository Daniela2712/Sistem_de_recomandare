import 'package:flutter/material.dart';
import '../../recomandationPage.dart';
import '../bottomNavBar/constants/color.dart';
import '../bottomNavBar/constants/text_style.dart';
import '../bottomNavBar/data/model.dart';
import '../bottomNavBar/widgets/custom_paint.dart';
import '../size_config.dart';

   class CustomBottonNavBar extends StatefulWidget {
   const CustomBottonNavBar({Key key}) : super(key: key);

   @override
   _CustomBottonNavBar createState() => _CustomBottonNavBar();
   }

   class _CustomBottonNavBar extends State<CustomBottonNavBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: navigationBar()
          ),
        ),
      );
  }

  int selectBtn = 0;
  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 55.0,
      duration: const Duration(milliseconds: 600),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
          topRight:
          Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState((){
                              selectBtn = i;
                            }),

              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 80.0 : 0.0;
    var width = isActive ? 70.0 : 0.0;
    return SizedBox(
      width: 35.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Expanded(
              child: AnimatedContainer(
                height: height,
                width: width,
                duration: const Duration(milliseconds: 600),
                child: isActive
                    ? CustomPaint(
                  painter: ButtonNotch(),
                )
                    : const SizedBox(),
              ),
        )
          ),
          Align(
            alignment: Alignment.center,
            child: Expanded(
              child: Image.asset(
                navBtn[i].imagePath,
                color: isActive ? selectColor : black,
                scale: 2,
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Expanded(
          //     child: Text(
          //     navBtn[i].name,
          //     style: isActive ? bntText.copyWith(color: selectColor) : bntText,
          //     )
          //   ),
          // ),

        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  navigateToNextActivity2(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => UserForm("Trip plan", "Brasov","Madrid","2022-08-29")
        )
    );
  }
}
