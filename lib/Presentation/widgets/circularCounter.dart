import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class CircularCounter extends StatelessWidget {
  final int duration;
  final CountDownController controller;
  CircularCounter({@required this.duration, @required this.controller});
  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: duration,
      initialDuration: 0,

      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
      controller: controller,
      width: 150,
      height: 150,
      ringColor: Colors.white30,
      fillColor: Colors.blue,
      // backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.butt,
      textStyle: TextStyle(
          fontSize: 33.0, color: Colors.blue, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        print('Countdown Started');
      },
      onComplete: () {
        Navigator.popAndPushNamed(context, "/thankyou");
        print('Countdown Ended');
      },
    );
  }
}
