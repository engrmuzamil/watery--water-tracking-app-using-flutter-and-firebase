import 'dart:async';

import 'package:drinkable/models/app_user.dart';
import 'package:drinkable/providers/home_provider.dart';
import 'package:drinkable/screens/customNavBar.dart';
import 'package:drinkable/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double calculatePercontage(var leftAmount, var totalAmount) {
    double percentage = (leftAmount / totalAmount) * 100;
    return percentage;
  }

  int getDrinkWater(var leftAmount, var totalAmount) {
    int drinkWater = totalAmount - leftAmount;

    return drinkWater * -1;
  }

  @override
  int percentage = 0;
  int drinkWater = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Consumer<HomeProvider>(builder: (context, provider, child) {
          drinkWater =
              getDrinkWater(provider.leftAmount, provider.getDailyTargetInt);
          percentage =
              calculatePercontage(drinkWater * -1, provider.getDailyTargetInt)
                  .toInt();
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              provider.leftAmount <= 0
                  ? Text('Goal\nReached',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Color(0xFF323062),
                          fontSize: 35,
                          fontWeight: FontWeight.w800))
                  : Column(
                      children: [
                        Text(
                          "${provider.getDailyTargetInt} mL",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF323062),
                              fontSize: 40,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Remaning: ${provider.leftAmount} mL",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF323062),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              Container(
                height: 500,
                child: WaterWidget(
                  percontValue: provider.leftAmount <= 0 ? 1 : percentage / 100,
                  appUser: provider.appUser,
                ),
              )
            ],
          );
        }),
      )),
      bottomNavigationBar: customNavBar(
        isActive: 1,
      ),
    );
  }
}

class WaterWidget extends StatefulWidget {
  final double percontValue;
  final AppUser appUser;
  const WaterWidget({Key key, this.percontValue, this.appUser})
      : super(key: key);

  @override
  State<WaterWidget> createState() => _WaterWidgetState();
}

class _WaterWidgetState extends State<WaterWidget>
    with TickerProviderStateMixin {
  AnimationController firstController;
  Animation<double> firstAnimation;
  int percontage;
  double valueAnimation;
  AnimationController secondController;
  Animation<double> secondAnimation;

  AnimationController thirdController;
  Animation<double> thirdAnimation;

  AnimationController fourthController;
  Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();

    double localPer = widget.percontValue * 100;
    percontage = localPer.toInt();
    valueAnimation = 1 + widget.percontValue;
    setState(() {});
    firstController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      });

    secondController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });

    Timer(Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(Duration(milliseconds: 1600), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  bool isLoading1 = false;
  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading1 == true
        ? Container(child: Center(child: CustomProgressIndicatior()))
        : Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: MyPainter(
                        firstAnimation.value * valueAnimation,
                        secondAnimation.value * valueAnimation,
                        thirdAnimation.value * valueAnimation,
                        fourthAnimation.value * valueAnimation,
                      ),
                      child: SizedBox(
                        height: widget.percontValue > 0.25
                            ? widget.percontValue < 1
                                ? MediaQuery.of(context).size.height *
                                        widget.percontValue -
                                    200
                                : MediaQuery.of(context).size.height * 1 - 220
                            : widget.percontValue > 0.10
                                ? MediaQuery.of(context).size.height *
                                        widget.percontValue +
                                    20
                                : MediaQuery.of(context).size.height *
                                        widget.percontValue +
                                    60,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Positioned(
                      bottom: widget.percontValue > 0.25
                          ? MediaQuery.of(context).size.width *
                                  widget.percontValue -
                              50
                          : 2,
                      left: 30,
                      child: Text(
                        (widget.percontValue * 100).toInt().toString() + "%",
                        style: GoogleFonts.poppins(
                            color: Color(0xFF323062),
                            fontSize: 35,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    widget.percontValue * 100 < 100
                        ? Positioned(
                            bottom: widget.percontValue > 0.25 ? 20 : 5,
                            right: 10,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  isLoading1 = true;
                                });

                                DateTime _time = DateTime.now();
                                await Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .addWater(250, _time);
                                setState(() {
                                  isLoading1 = false;
                                });
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xFF323062),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ))
                        : Container(),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 2 - 80,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Image.asset(
                      widget.appUser.gender == null
                          ? "assets/icons/femaleA.png"
                          : widget.appUser.gender == "male"
                              ? "assets/icons/maleA.png"
                              : "assets/icons/femaleA.png",
                      color: Colors.white.withOpacity(0.5),
                      colorBlendMode: BlendMode.modulate,
                      fit: BoxFit.fill,
                    ),
                  )),
            ],
          );
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFF8E8BFF)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
