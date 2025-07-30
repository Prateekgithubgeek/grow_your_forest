import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/forest_provider.dart';
import '../widgets/forest_painter.dart';
import 'task_screen.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trees = context.watch<ForestProvider>().trees;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Sky Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE1F5FE),
                  Color(0xFFB3E5FC),
                  Color(0xFF81D4FA),
                  Color(0xFF0288D1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),


          LayoutBuilder(
            builder: (context, constraints) {
              return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: ForestPainter(trees: trees),
              );
            },
          ),

          Positioned(
            top: 150,
            left: 30,
            child: AnimatedContainer(
              duration: Duration(seconds: 3),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.yellow.shade300, Colors.orangeAccent.withOpacity(0.7)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 40,
                    spreadRadius: 8,
                  )
                ],
              ),
            ),
          ),
          Positioned(

            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    "🌿 Prateek's Forest 🌿",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.95),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 350,
            child: Material(
              color: Colors.transparent,
              elevation: 22,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  context.read<ForestProvider>().resetForest();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.restart_alt, color: Colors.white, size: 20,),
                      SizedBox(width:4 ),
                      Text(
                        " ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            bottom: 60,
            right: 14,
            child: Material(
              color: Colors.transparent,
              elevation: 10,
              borderRadius: BorderRadius.circular(40),
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (_, animation, secondaryAnimation) => TaskScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        final tween = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero);
                        final curveTween = CurveTween(curve: Curves.easeInOut);

                        return SlideTransition(
                          position: animation.drive(curveTween).drive(tween),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );

                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF43A047), Color(0xFF2E7D32)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.4),
                        blurRadius: 16,
                        spreadRadius: 1,
                        offset: Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(-2, -2),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.15),
                        ),
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.task_alt_rounded, color: Colors.white, size: 22),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'View Tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing : 1.1,
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
