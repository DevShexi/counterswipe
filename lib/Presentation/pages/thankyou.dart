import 'package:counterswipe/Presentation/widgets/circularCounter.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class ThankYou extends StatefulWidget {
  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(75),
                      ),
                      color: Color(0xffFFD93E),
                    ),
                    child: Center(
                      child: Text(
                        'ThankYou!',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          color: Colors.green,
                        ),
                      ),
                    )),
                Positioned(
                  top: -160,
                  child: Container(
                    width: 110,
                    height: 110,
                    child:
                        Image.asset("images/tooth.png", fit: BoxFit.scaleDown),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
