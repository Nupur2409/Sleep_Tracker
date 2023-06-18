 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:sleeptracker/alarm/widgets/widget.dart';



class alarm extends StatefulWidget {
  const alarm({super.key});

  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(hours: 8 ),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xffffebe8),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade300,
                      value: progress,
                      strokeWidth: 6,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.isDismissed) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 300,
                            child: CupertinoTimerPicker(
                              initialTimerDuration: controller.duration!,
                              onTimerDurationChanged: (time) {
                                setState(() {
                                  controller.duration = time;
                                });
                              },
                            ),
                          ),
                        );
                      }
                    },
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) => Text(
                        countText,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.isAnimating) {
                        controller.stop();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        controller.reverse(
                            from: controller.value == 0 ? 1.0 : controller.value);
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    child: RoundButton( 
                      icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.reset();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                    child: RoundButton(
                      icon: Icons.stop,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
