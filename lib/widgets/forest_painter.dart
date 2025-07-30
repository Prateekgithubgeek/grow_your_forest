import 'package:flutter/material.dart';
import '../models/tree_model.dart';

class ForestPainter extends CustomPainter {
  final List<Tree> trees;

  ForestPainter({required this.trees});

  @override
  void paint(Canvas canvas, Size size) {
    final groundRect = Rect.fromLTWH(0, size.height * 0.75, size.width, size.height * 0.25);
    final groundGradient = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF4CAF50),
          Color(0xFF388E3C),
          Color(0xFF2E7D32),
        ],
      ).createShader(groundRect);
    canvas.drawRect(groundRect, groundGradient);



    for (final tree in trees) {
      final base = Offset(size.width * tree.x, size.height * tree.y);
      switch (tree.speciesId) {
        case 1:
          _drawSpecies1(canvas, base, tree.stage);
          break;
        case 2:
          _drawSpecies2(canvas, base, tree.stage);
          break;
        case 3:
          _drawSpecies3(canvas, base, tree.stage);
          break;
      }
    }
  }

  void _drawSpecies1(Canvas canvas, Offset base, int stage) {
    final trunk = Paint()..color = Colors.brown;
    final leaves = Paint()..color = Colors.green.shade600;

    double trunkHeight = 20 + (stage * 8);
    double trunkWidth = 6 + (stage * 1.5);

    canvas.drawRect(
      Rect.fromLTWH(base.dx - trunkWidth / 2, base.dy - trunkHeight, trunkWidth, trunkHeight),
      trunk,
    );

    if (stage >= 1) {
      canvas.drawCircle(Offset(base.dx, base.dy - trunkHeight - 12), 10 + stage.toDouble(), leaves);
    }
    if (stage >= 2) {
      canvas.drawCircle(Offset(base.dx - 14, base.dy - trunkHeight - 22), 8 + stage.toDouble(), leaves);
      canvas.drawCircle(Offset(base.dx + 14, base.dy - trunkHeight - 22), 8 + stage.toDouble(), leaves);
    }
    if (stage >= 3) {
      canvas.drawCircle(Offset(base.dx, base.dy - trunkHeight - 34), 7 + stage.toDouble(), leaves);
    }
  }

  void _drawSpecies2(Canvas canvas, Offset base, int stage) {
    final trunk = Paint()..color = Colors.brown.shade800;
    final leaves = Paint()..color = Colors.teal.shade400;

    double trunkHeight = 25 + (stage * 7);
    double trunkWidth = 7 + stage.toDouble();

    canvas.drawRect(
      Rect.fromLTWH(base.dx - trunkWidth / 2, base.dy - trunkHeight, trunkWidth, trunkHeight),
      trunk,
    );

    if (stage >= 1) {
      canvas.drawOval(Rect.fromCenter(center: Offset(base.dx, base.dy - trunkHeight - 10), width: 28, height: 18), leaves);
    }
    if (stage >= 2) {
      canvas.drawOval(Rect.fromCenter(center: Offset(base.dx - 14, base.dy - trunkHeight - 22), width: 20, height: 14), leaves);
      canvas.drawOval(Rect.fromCenter(center: Offset(base.dx + 14, base.dy - trunkHeight - 22), width: 20, height: 14), leaves);
    }
    if (stage >= 3) {
      canvas.drawOval(Rect.fromCenter(center: Offset(base.dx, base.dy - trunkHeight - 32), width: 16, height: 12), leaves);
    }
  }

  void _drawSpecies3(Canvas canvas, Offset base, int stage) {
    final trunk = Paint()..color = Colors.deepOrange.shade400;
    final leaves = Paint()..color = Colors.lime.shade500;

    double trunkHeight = 20 + (stage * 6);
    double trunkWidth = 5 + (stage * 1.5);

    canvas.drawRect(
      Rect.fromLTWH(base.dx - trunkWidth / 2, base.dy - trunkHeight, trunkWidth, trunkHeight),
      trunk,
    );

    if (stage >= 1) {
      canvas.drawCircle(Offset(base.dx, base.dy - trunkHeight - 8), 10, leaves);
    }
    if (stage >= 2) {
      canvas.drawCircle(Offset(base.dx - 10, base.dy - trunkHeight - 16), 8, leaves);
      canvas.drawCircle(Offset(base.dx + 10, base.dy - trunkHeight - 16), 8, leaves);
    }
    if (stage >= 3) {
      canvas.drawCircle(Offset(base.dx, base.dy - trunkHeight - 26), 6, leaves);
    }
    if (stage >= 4) {
      canvas.drawCircle(Offset(base.dx - 7, base.dy - trunkHeight - 32), 5, leaves);
      canvas.drawCircle(Offset(base.dx + 7, base.dy - trunkHeight - 32), 5, leaves);
    }
  }

  @override
  bool shouldRepaint(covariant ForestPainter oldDelegate) => true;
}
