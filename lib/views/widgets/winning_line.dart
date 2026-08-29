import 'package:flutter/material.dart';

class WinningLine extends StatelessWidget {
  const WinningLine({super.key, required this.pattern});

  final List<int> pattern;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(painter: WinningLinePainter(pattern)),
      ),
    );
  }
}

class WinningLinePainter extends CustomPainter {
  WinningLinePainter(this.pattern);

  final List<int> pattern;

  @override
  void paint(Canvas canvas, Size size) {
    if (pattern.length != 3) return;

    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final cellWidth = size.width / 3;
    final cellHeight = size.height / 3;

    final start = getCenter(pattern.first, cellWidth, cellHeight);

    final end = getCenter(pattern.last, cellWidth, cellHeight);
   
   // draw line
    canvas.drawLine(start, end, paint);
  }

  Offset getCenter(int index, double cellWidth, double cellHeight) {
    final row = index ~/ 3;
    final column = index % 3;

    return Offset(
      column * cellWidth + cellWidth / 2,
      row * cellHeight + cellHeight / 2,
    );
  }

  @override
  bool shouldRepaint(covariant WinningLinePainter oldDelegate) {
    return oldDelegate.pattern != pattern;
  }
}
