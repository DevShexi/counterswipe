import 'package:counterswipe/Presentation/widgets/circularCounter.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  CountDownController _controller = CountDownController();
  int _duration = 60;

  bool startTimer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy < -100) {
          print("Swipe Detected");
          setState(() {
            startTimer = !startTimer;
          });
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            !startTimer
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Swipe up to start the timer",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : SizedBox(
                    height: 100,
                  ),
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
                      color: Color(0xffFFD93E)),
                  child: startTimer
                      ? CircularCounter(
                          duration: _duration, controller: _controller)
                      : null,
                ),
                Positioned(
                  top: startTimer ? -160 : 20,
                  child: Container(
                    width: 110,
                    height: 110,
                    child:
                        Image.asset("images/tooth.png", fit: BoxFit.scaleDown),
                  ),
                )
              ],
            ),
            startTimer
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Total Time: 1 minute",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    ));
  }
}
