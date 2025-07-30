import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/forest_provider.dart';
import '../providers/forest_provider.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();


}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  List<bool> completed = [false, false, false];
  List<String> taskNames = ["Water the saplings", "Check for pests", "Add Compost"];
  late List<AnimationController> controllers;
  late List<Animation<double>> animations;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      3,
          (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    animations = controllers
        .map((c) => Tween<double>(begin: 0, end: pi).animate(c))
        .toList();
  }

  void handleTap(int index) {
    if (!completed[index]) {
      controllers[index].forward();
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          completed[index] = true;
        });
        context.read<ForestProvider>().completeTask();
      });
    }
  }

  bool allDone() => completed.every((e) => e);

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Widget buildTaskCard(int index) {
    return FlipCard(
      flipOnTouch: !completed[index],
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        height: 80,
        decoration: BoxDecoration(
          color: Color(0xFFF0FFF0),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey[600],
                size: 26,
              ),
              SizedBox(width: 16),
              Text(
                taskNames[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
        ),
      ),
      back: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[200]!, Colors.green[500]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green[800],
                  size: 26,
                ),
                SizedBox(width: 16),
                Text(
                  "Completed Task ${index + 1}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[900],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onFlipDone: (done) {
        if (done && !completed[index]) {
          setState(() => completed[index] = true);
          context.read<ForestProvider>().completeTask();
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3FCE9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Stack(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA8E6CF), Color(0xFFB2EBF2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: Text(
                    '🌿 Your Tasks Today 🌿 ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            ...List.generate(3, (index) => buildTaskCard(index)),
            SizedBox(height: 40), // Space before the button to push it upward
            AnimatedContainer(
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeInOut,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: allDone() ? Colors.green[700] : Colors.green[100],
                  foregroundColor: Colors.white,
                  elevation: 4,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  allDone() ? "🌳 Done – Grow Forest" : "Back to Forest",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}
