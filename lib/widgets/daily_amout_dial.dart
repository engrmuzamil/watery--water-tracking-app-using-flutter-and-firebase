import 'package:drinkable/widgets/water_effect.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// providers
import '../providers/home_provider.dart';

double calculatePercontage(var leftAmount, var totalAmount) {
  double percentage = (leftAmount / totalAmount) * 100;
  return percentage;
}

int getDrinkWater(var leftAmount, var totalAmount) {
  int drinkWater = totalAmount - leftAmount;

  return drinkWater * -1;
}

class DailyAmountDial extends StatelessWidget {
  int percentage = 0;
  int drinkWater = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        drinkWater =
            getDrinkWater(provider.leftAmount, provider.getDailyTargetInt);
        percentage =
            calculatePercontage(drinkWater * -1, provider.getDailyTargetInt)
                .toInt();

        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -pi / 2,
              child: Container(
                width: 230,
                height: 230,
                child: CustomPaint(
                  painter: DialPainter(provider.targetReached),
                ),
              ),
            ),
            provider.leftAmount <= 0
                ? Text('Goal\nReached',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Color(0xFF323062),
                        fontSize: 35,
                        fontWeight: FontWeight.w800))
                : Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "$percentage%",
                            style: GoogleFonts.poppins(
                                color: Color(0xFF323062),
                                fontSize: 40,
                                fontWeight: FontWeight.w700)),
                        TextSpan(text: '\n'),
                        TextSpan(
                            text: '${provider.getDailyTargetInt} mL',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF323062),
                                fontSize: 30,
                                fontWeight: FontWeight.w600)),
                        TextSpan(text: '\n'),
                        TextSpan(
                            text: '${-1 * provider.leftAmount} mL',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF323062),
                                fontSize: 20,
                                fontWeight: FontWeight.w400)),
                        TextSpan(text: '\n'),
                      ]),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class DialPainter extends CustomPainter {
  double percent;
  DialPainter(this.percent);
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.height / 2, size.width / 2);
    double fullRadius = (size.height / 2);
    Paint circle = Paint()
      ..color = Color(0xFF8C88FF).withOpacity(0.2)
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;
    Paint arc = Paint()
      ..color = Color(0xFF8E8BFF)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), fullRadius - 2, circle);
    canvas
      ..drawArc(Rect.fromCircle(center: center, radius: fullRadius - 2), 0,
          2 * pi * percent, false, arc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
