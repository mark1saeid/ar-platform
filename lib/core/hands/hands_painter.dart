import 'dart:ui';

import 'package:flutter/material.dart';

class HandsPainter extends CustomPainter {
  final List<Offset> points;
  final double ratio;

  HandsPainter({
    this.points,
    this.ratio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // todo may be need cicular
    var pointPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 15;

    // todo canvas.drawCircle(Offset(0.0, 0.0), 50, pointPaint);
    //canvas.drawCircle(points[0], 12, pointPaint);

    canvas.drawPoints(
      PointMode.points,
      points.map((point) => point * ratio).toList(),
      pointPaint,
    );

    /*

    canvas.drawPoints(
      PointMode.polygon,
      points.sublist(0, 5).map((point) => point * ratio).toList(),
      linePaint,
    );
    canvas.drawPoints(
      PointMode.polygon,
      [points[0], ...points.sublist(5, 9)]
          .map((point) => point * ratio)
          .toList(),
      linePaint,
    );
    canvas.drawPoints(
      PointMode.polygon,
      [points[0], ...points.sublist(9, 13)]
          .map((point) => point * ratio)
          .toList(),
      linePaint,
    );
    canvas.drawPoints(
      PointMode.polygon,
      [points[0], ...points.sublist(13, 17)]
          .map((point) => point * ratio)
          .toList(),
      linePaint,
    );
    canvas.drawPoints(
      PointMode.polygon,
      [points[0], ...points.sublist(17, 21)]
          .map((point) => point * ratio)
          .toList(),
      linePaint,
    );
  }*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
