import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prayer_time_qubla/constants/text_style.dart';

class RadialGradientAnimation extends StatefulWidget {
  const RadialGradientAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RadialGradientAnimationState createState() =>
      _RadialGradientAnimationState();
}

class _RadialGradientAnimationState extends State<RadialGradientAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 86400),
    );
    final now = DateTime.now();
    final secondsSinceMidnight = now.hour * 3600 + now.minute * 60 + now.second;
    final initialAnimationValue = secondsSinceMidnight / 86400.0;
    animation = Tween<double>(begin: initialAnimationValue, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: RadialGradientBorderPainter(animation),
        size: const Size.square(200),
      ),
    );
  }
}

class RadialGradientBorderPainter extends CustomPainter {
  final Animation<double> animation;

  RadialGradientBorderPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFE9E9FF)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    // Calculate the outer radius for the ring
    double outerRadius = size.width / 2;

    // Calculate animation values
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * animation.value;

    // Draw the ring
    canvas.drawCircle(size.center(Offset.zero), outerRadius, paint);

    // Draw the animated border
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: outerRadius),
      startAngle,
      sweepAngle,
      false,
      paint
        ..shader = _buildGradient(size).createShader(
          Rect.fromCircle(
            center: size.center(Offset.zero),
            radius: outerRadius,
          ),
        ),
    );

    TextSpan title =  TextSpan(
      style: AppTextStyle.white32,
      text: '${ DateTime.now().hour}:${ DateTime.now().minute}',
    );
    TextSpan subtitle = const TextSpan(
      style: AppTextStyle.white10w600,
      text: 'Следущая молитва Зухр',
    );
    TextSpan span = const TextSpan(
      style: AppTextStyle.white10,
      text: 'Через 2ч 7мин',
    );

    TextPainter tpTitle = TextPainter(
      text: title,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tpTitle.layout();
    tpTitle.paint(
      canvas,
      Offset(size.width / 2 - (tpTitle.width / 2),
          size.height / 2 - (tpTitle.height / 2) - 10),
    );
    TextPainter tpSubtitle = TextPainter(
      text: subtitle,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tpSubtitle.layout();
    tpSubtitle.paint(
      canvas,
      Offset(size.width / 2 - (tpSubtitle.width / 2),
          size.height / 2 - (tpSubtitle.height / 2) + 20),
    );

    TextPainter tpSpan = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tpSpan.layout();
    tpSpan.paint(
      canvas,
      Offset(size.width / 2 - (tpSpan.width / 2),
          size.height / 2 - (tpSpan.height / 2) + 40),
    );
  }

  RadialGradient _buildGradient(Size size) {
    return const RadialGradient(
      center: Alignment.center,
      radius: 1.0,
      colors: [
        Colors.white,
        Color(0xFF626DF5),
        Color(0xFFE9E9FF),
      ],
      stops: [0.0, 0.7, 1.0],
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
